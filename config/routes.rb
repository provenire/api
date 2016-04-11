Rails.application.routes.draw do


  # API
  jsonapi_resources :affiliations
  jsonapi_resources :annotations
  jsonapi_resources :artifacts
  jsonapi_resources :citations
  jsonapi_resources :events
  jsonapi_resources :interactions
  jsonapi_resources :pages
  jsonapi_resources :people
  jsonapi_resources :places
  jsonapi_resources :sources
  jsonapi_resources :users
  jsonapi_resources :verbs
end
