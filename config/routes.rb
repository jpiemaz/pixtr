Pixtr::Application.routes.draw do
  get "/galleries/random" => "random_galleries#show"
 
  root to: "home#index"
  
  resources :galleries do
    resources :images, only: [:new, :create]
  end
  
  resources :groups, only: [:index, :new, :create, :show]
  
  resources :images, except: [:index, :new, :create] do
    resources :comments, only: [:create]
  end
  
  resources :users, only: [:show] do
    member do
      post "follow" => "following_relationships#create"
      delete "unfollow" => "following_relationships#destroy"
    end
  end
end
