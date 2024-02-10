require 'json'
require_relative 'function_tool_helper'

module WebhookHelper
  include FunctionToolHelper
  def handle_webhook(request)
    payload = request
    type = payload['type']
    case type
    when 'function-call'
      handle_function_call(payload)
    when 'status-update'
      handle_status_update(payload)
    when 'assistant-request'
      handle_assistant_request(payload)
    when 'end-of-call-report'
      handle_end_of_call_report(payload)
    when 'speech-update'
      handle_speech_update(payload)
    when 'transcript'
      handle_transcript(payload)
    when 'hang'
      handle_hang(payload)
    else
      # ignore other types of messages
    end
  end

  private

  def handle_function_call(payload)

    function_call = payload['functionCall']
    raise 'Invalid Request.' unless function_call

    name = function_call['name']
    parameters = function_call['parameters']

    if name == 'getRandomName'
      result = get_random_name(parameters)
    elsif name == 'getCharacterInspiration'
      result = get_character_inspiration(parameters)
    end
    puts result
    result
  end

  def handle_status_update(payload)
    status = payload['status']

    # You can then use this status to update your database or perform other actions
    # For example, you might want to log the status update or notify other parts of your system
  end

  def handle_assistant_request(payload)
    assistant = if payload['call']
      {
        'name' => 'Paula',
        'model' => {
          'provider' => 'openai',
          'model' => 'gpt-3.5-turbo',
          'temperature' => 0.7,
          'systemPrompt' => "You're Paula, an AI assistant who can help user draft beautiful emails to their clients based on the user requirements. Then Call sendEmail function to actually send the email.",
          'functions' => [
            {
              'name' => 'sendEmail',
              'description' => 'Send email to the given email address and with the given content.',
              'parameters' => {
                'type' => 'object',
                'properties' => {
                  'email' => {
                    'type' => 'string',
                    'description' => 'Email to which we want to send the content.',
                  },
                  'content' => {
                    'type' => 'string',
                    'description' => 'Actual Content of the email to be sent.',
                  },
                },
                'required' => ['email'],
              },
            },
          ],
        },
        'voice' => {
          'provider' => '11labs',
          'voiceId' => 'paula',
        },
        'firstMessage' => "Hi, I'm Paula, your personal email assistant.",
      }
    else
      nil
    end

    raise 'Invalid call details provided.' unless assistant

    { 'assistant' => assistant }
  end

  def handle_end_of_call_report(payload)
    end_of_call_report = payload['endOfCallReport']

    # You can then use this report to update your database or perform other actions
    # For example, you might want to store the report for later analysis or trigger some post-call actions
  end

  def handle_speech_update(payload)
    speech_update = payload['speechUpdate']

    # You can then use this update to perform actions in your application
    # For example, you might want to update the UI to reflect who is currently speaking
  end

  def handle_transcript(payload)
    transcript = payload['transcript']

    # You can then use this transcript to update your database or perform other actions
    # For example, you might want to store the transcript for later analysis or display it in the UI
  end

  def handle_hang(payload)
    hang = payload['hang']

    # You can then use this event to perform actions in your application
    # For example, you might want to log the hang event or notify your team of potential issues
  end
end