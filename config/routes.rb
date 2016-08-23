Rails.application.routes.draw do

  get 'recommended_users/index'

  get 'recommended_users/create'

  get 'recommended_users/update'

  get 'recommended_users/destroy'

  devise_for :users
  root to: 'pages#home'
  root to: "pages#dashboard", constraints: lambda { |r| r.env["warden"].authenticate? }
  get "/dashboard/", to: "pages#dashboard"
  resources :categories, only: [:index]
  resources :skills, only: [:index]
  resources :user_skills, only: [:create, :destroy]
  resources :connections, only: [:index, :create, :update, :show] do
    resources :meetings, only: [:create, :show, :update] do
      resources :messages, only: [:create]
    end
  end
end
