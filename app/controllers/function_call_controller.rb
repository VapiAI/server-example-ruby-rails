class FunctionCallController < ApplicationController
  include FunctionToolHelper

  skip_before_action :verify_authenticity_token
  def create_basic
    payload = params[:message]
    type = payload['type']

    case type
    when 'function-call'
      function_call = payload['functionCall']

      raise 'Invalid Request.' unless function_call

      name = function_call['name']
      parameters = function_call['parameters']

      if name == 'getRandomName'
        result = get_random_name(parameters)
      end

      render json: result, status: :ok
    else
      # ignore other types of messages
      return
    end
  end

  def create_rag
    payload = params[:message]
    type = payload['type']

    case type
    when 'function-call'
      function_call = payload['functionCall']

      raise 'Invalid Request.' unless function_call

      name = function_call['name']
      parameters = function_call['parameters']

      
      if name == 'getCharacterInspiration'
        result = get_character_inspiration(parameters)
      end

      render json: result, status: :ok
    else
      # ignore other types of messages
      return
    end
  end
end