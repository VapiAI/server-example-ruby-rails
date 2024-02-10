require 'net/http'
require 'json'
require 'uri'

module FunctionToolHelper
  def get_character_inspiration(inspiration)
    fallback_response = {
      'result' => 'Sorry, I am dealing with a technical issue at the moment, perhaps because of heightened user traffic. Come back later and we can try this again. Apologies for that.'
    }

    if inspiration
      begin
        # Handle RAG

        response = {
          'response' => 'This is a placeholder response for the getCharacterInspiration function. It should be replaced with the actual implementation.'
        }

        return {
          'result' => response['response'],
          'forwardToClientEnabled' => true
        }
      rescue => error
        puts "error: #{error.message}"
        return fallback_response
      end
    else
      return fallback_response
    end
  end

  def get_random_name(params)
    puts "get_random_name"
    nats = [
      "AU",
      "CA",
      "FR",
      "IN",
      "IR",
      "MX",
      "NL",
      "NO",
      "NZ",
      "RS",
      "TR",
      "US"
    ]

    nat = params['nat']&.upcase || nats.first || ""
    # Encode the params hash as JSON
    json_params = JSON.generate(params)

    # URI encode the JSON params
    query_params = URI.encode_www_form('json' => json_params)

    url = URI.parse("https://randomuser.me/api/?#{query_params}")
    begin
      response = Net::HTTP.get(url)
      if !response
        raise StandardError, "Error fetching random name"
      end
      data = JSON.parse(response)
      name = data['results'][0]['name']
      return {
        'result' => "#{name['first']} #{name['last']}"
      }
    rescue => err
      raise StandardError, "Error fetching random name"
    end
  end
end