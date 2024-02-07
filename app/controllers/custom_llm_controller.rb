require 'types/vapi'

class CustomLlmController < ApplicationController
  include ActionController::Live

  skip_before_action :verify_authenticity_token

  def create
    response.headers['Content-Type'] = 'text/event-stream'
    response.headers['Cache-Control'] = 'no-cache'
    response.headers['Connection'] = 'keep-alive'

    begin
      payload = params

      unless payload
        return render json: { error: 'Missing payload in request body' }, status: :bad_request
      end

      Rails.logger.info("Received payload: #{payload}")

      model = payload[:model] || 'gpt-3.5-turbo'
      messages = payload[:messages]
      max_tokens = payload[:max_tokens] || 150
      temperature = payload[:temperature] || 0.7
      stream = payload[:stream]

      client = OpenAI::Client.new

      if stream
        client.chat(
          parameters: {
            model: model,
            messages: messages,
            max_tokens: max_tokens,
            temperature: temperature,
            stream: proc do |chunk, _bytesize|
              response.stream.write("data: #{chunk.to_json}\n\n")
            end
          }
        )
      else
        completion = client.chat(
          parameters: {
            model: model,
            messages: messages,
            max_tokens: max_tokens,
            temperature: temperature
          }
        )
        render json: completion, status: :ok
      end
    rescue => e
      Rails.logger.error("An error occurred: #{e.message}")
      # Rails.logger.error(e.backtrace.join("\n"))
      render json: { error: e.message }, status: :internal_server_error
    ensure
      response.stream.close
    end
  end
end