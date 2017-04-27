Rails.application.routes.draw do
  post '/update_outside', to: 'contacts#update_outside'
  resources :contacts

  root 'contacts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
