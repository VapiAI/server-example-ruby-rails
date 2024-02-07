class InboundController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    payload = params[:message]
    case payload[:type]
    when 'assistant-request'
      assistant = payload[:call] ? create_assistant : nil
      if assistant
        render json: { assistant: assistant }, status: :ok
      else
        render json: { error: 'Assistant not created' }, status: :internal_server_error
      end
    else
      render json: { error: 'Unhandled message type' }, status: :internal_server_error
    end
  rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def create_assistant
    {
      name: 'Paula',
      model: {
        provider: 'openai',
        model: 'gpt-3.5-turbo',
        temperature: 0.7,
        systemPrompt: 'You\'re Paula, an AI assistant who can help user draft beautiful emails to their clients based on the user requirements. Then Call sendEmail function to actually send the email.',
        functions: [
          {
            name: 'sendEmail',
            description: 'Send email to the given email address and with the given content.',
            parameters: {
              type: 'object',
              properties: {
                email: {
                  type: 'string',
                  description: 'Email to which we want to send the content.'
                },
                content: {
                  type: 'string',
                  description: 'Actual Content of the email to be sent.'
                }
              },
              required: ['email']
            }
          }
        ]
      },
      voice: {
        provider: '11labs',
        voiceId: 'paula'
      },
      firstMessage: 'Hi, I\'m Paula, your personal email assistant.'
    }
  end
end