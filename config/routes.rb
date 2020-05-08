Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  resources :dogs do
    # Here I am only adding a create route as per the requirement to
    # allow a user to like (CREATE)
    resources :likes, only: [:create]
  end

  root to: "dogs#index"
end
