Rails.application.routes.draw do
  root 'kitchen_sinks#new'
  resources :kitchen_sinks
  namespace :test do
    post 'create_blob/html_error', to: 'create_blob#html_error'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
