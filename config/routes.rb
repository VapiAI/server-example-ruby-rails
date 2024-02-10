Rails.application.routes.draw do
  post '/api/inbound', to: 'inbound#create'
  post '/api/outbound', to: 'outbound#create'
  post '/api/webhook', to: 'webhook#create'


  post '/api/functions/basic', to: 'function_call#create_basic'
  post '/api/functions/rag', to: 'function_call#create_rag'

  post '/api/custom-llm/basic/chat/completions', to: 'custom_llm#create_basic'
  post '/api/custom-llm/openai-sse/chat/completions', to: 'custom_llm#create_openai_sse'
  post '/api/custom-llm/openai-advanced/chat/completions', to: 'custom_llm#create_openai_advanced'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
