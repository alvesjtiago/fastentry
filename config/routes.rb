Fastentry::Engine.routes.draw do
  root to: "dashboard#index"

  delete "invalidate/:key" => "cache#invalidate", as: "invalidate_key"
end
