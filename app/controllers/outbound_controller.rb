require 'net/http'
require 'json'

class OutboundController < ApplicationController

  skip_before_action :verify_authenticity_token
  def create
    # Extract phoneNumberId, assistantId, and customerNumber from the request body
    phoneNumberId = params[:phoneNumberId]
    assistantId = params[:assistantId]
    customerNumber = params[:customerNumber]

    begin
      # Handle Outbound Call logic here.
      # This can initiate an outbound call to a customer's phonenumber using Vapi.

      uri = URI("#{ENV['VAPI_BASE_URL']}/call/phone")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'

      request = Net::HTTP::Post.new(uri.path)
      request['Content-Type'] = 'application/json'
      request['Authorization'] = "Bearer #{ENV['VAPI_API_KEY']}"
      request.body = {
        phoneNumberId: phoneNumberId,
        assistantId: assistantId,
        customer: {
          number: customerNumber
        }
      }.to_json

      response = http.request(request)

      unless response.is_a?(Net::HTTPSuccess)
        raise "HTTP error! status: #{response.code}"
      end

      data = JSON.parse(response.body)
      render json: data, status: 200
    rescue => error
      render json: {
        message: 'Failed to place outbound call',
        error: error.message
      }, status: 500
    end
  end
end