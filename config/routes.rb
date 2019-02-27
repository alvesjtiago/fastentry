require 'awesome_print'

Fastentry::Engine.routes.draw do
  root to: "dashboard#index"

  get "cache_item/:key" => "cache#show", as: "cache"
  delete "invalidate/:key" => "cache#invalidate", as: "invalidate_key"
  delete "invalidate_multiple" => "cache#invalidate_multiple", as: "invalidate_multiple_keys"

  resources :stats, only: [:index]
end
