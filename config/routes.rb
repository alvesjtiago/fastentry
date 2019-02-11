require 'awesome_print'

Fastentry::Engine.routes.draw do
  root to: "dashboard#index"

  get "cache_item/:key" => "cache#show", as: "cache"
  delete "invalidate/:key" => "cache#invalidate", as: "invalidate_key"
end
