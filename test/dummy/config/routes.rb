Rails.application.routes.draw do
  root 'kitchen_sink#new'
  resources :kitchen_sinks
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
