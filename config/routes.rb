Rails.application.routes.draw do

  resources :posts do
    resources :comments
  end

  resources :comments do
    resources :comments
  end

  defaults format: :xls do
    namespace :api do
      get '/posts/:post_id/comments', to: 'comments#index', post_id: /\d+/
    end
  end
end
