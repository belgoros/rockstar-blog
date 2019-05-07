Rails.application.routes.draw do
  resources :posts do
    resources :comments
  end

  resources :comments do
    resources :comments
  end
end
