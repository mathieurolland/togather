Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  root to: "pages#dashboard", constraints: lambda { |r| r.env["warden"].authenticate? }
  get "/dashboard/", to: "pages#dashboard"
  resource :recommended_users, only: [:destroy, :create, :update]
  resources :categories, only: [:index]
  resources :skills, only: [:index]
  resources :user_skills, only: [:create, :destroy]
  resources :connections, only: [:index, :create, :update, :show] do
    resources :meetings, only: [:create, :show, :update] do
      resources :messages, only: [:create]
    end
  end
end
