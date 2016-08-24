Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "registrations" }
  root to: "pages#dashboard", constraints: lambda { |r| r.env["warden"].authenticate? }
  root to: 'pages#home'

  get "/dashboard/", to: "pages#dashboard"
  get "/dashboard/edit-skills", to: "pages#edit_skills"
  patch "/dashboard/update-skills", to: "pages#update_skills"
  put "/dashboard/update-skills", to: "pages#update_skills"
  resources :recommended_users, only: [:create, :update, :destroy]
  resources :categories, only: [:index]
  resources :skills, only: [:index]
  resources :user_skills, only: [:create, :destroy]
  resources :connections, only: [:index, :create, :update, :show] do
    resources :meetings, only: [:create, :show, :update] do
      resources :messages, only: [:create]
    end
  end
end
