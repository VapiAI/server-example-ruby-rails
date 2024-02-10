class WebhookController < ApplicationController
  include WebhookHelper

  skip_before_action :verify_authenticity_token, only: [:create]
  def create
    payload = params[:message]
    type = payload[:type]
    case type
    when 'function-call'
      result = handle_function_call(payload)
    when 'status-update'
      result = handle_status_update(payload)
    when 'assistant-request'
      result = handle_assistant_request(payload)
    when 'end-of-call-report'
      result = handle_end_of_call_report(payload)
    when 'speech-update'
      result = handle_speech_update(payload)
    when 'transcript'
      result = handle_transcript(payload)
    when 'hang'
      result = handle_hang(payload)
    else
      # ignore other types of messages
    end
    render json: result, status: :ok
  rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end

  
end
