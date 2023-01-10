Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :dish, only: [:show, :update]
  resources :chef, only: :show do
    resources :ingredients, :controller => :chef_ingredients, only: :index
  end
end
