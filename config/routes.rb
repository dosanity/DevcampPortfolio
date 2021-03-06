Rails.application.routes.draw do
  resources :topics, only: [:index, :show]

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :portfolios, except: [:show] do
    put :sort, on: :collection
  end
  get 'angular-items', to: 'portfolios#angular'
  get 'portfolio/:id', to: 'portfolios#show', as: 'portfolio_show'

  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'news', to: 'pages#tech_news'
  get 'edit', to: 'pages#edit'

  resources :blogs do
    member do
      get :toggle_status
    end
    resources :comment 
  end
  
  resources :portfolio do
    member do
      get :toggle_status
    end
  end
  
  post '/blogs/:blog_id/comment' => 'comment#create', :as => 'create_blog_comment'
  
  #mount ActionCable.server => '/cable'
  
  root to: 'pages#home'
end