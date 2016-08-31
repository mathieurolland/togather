Rails.application.routes.draw do

   devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: "users/registrations"
  }
  mount Attachinary::Engine => "/attachinary"
  root to: "pages#partner", constraints: lambda { |r| r.env["warden"].authenticate? && r.env["warden"].user.status == true }
  root to: "pages#dashboard", constraints: lambda { |r| r.env["warden"].authenticate? }
  root to: 'pages#home'
  get '/users/:id', to: "users#summary", as: "user_summary"
  get "/dashboard/", to: "pages#dashboard"
  get "/dashboard/edit-skills", to: "pages#edit_skills"
  patch "/dashboard/update-skills", to: "pages#update_skills"
  put "/dashboard/update-skills", to: "pages#update_skills"
  get "/partner/", to: "pages#partner"
  patch "/connections/:connection_id/meetings/:id/review", to: "meetings#change_review", as: "review"
  put "/connections/:connection_id/meetings/:id/review", to: "meetings#change_review"
  delete "/connections/:connection_id/meetings/:id/review", to: "meetings#destroy_review"
  get "/connections/:connection_id/meetings/:id/edit-review", to: "meetings#edit_review", as: "edit_review"
  patch "/connections/:connection_id/meetings/:id/status/", to: "connections#finalize_status", as: "status"
  put "/connections/:id/status/", to: "connections#finalize-status"
  patch "/connections/:id/cancel/" ,to: "connections#cancel", as: "cancel_connection"
  put "/connections/:id/cancel/" ,to: "connections#cancel"
  patch "/connections/:id/decline/" ,to: "connections#decline", as: "decline_connection"
  put "/connections/:id/decline/" ,to: "connections#decline"
  resources :recommended_users, only: [:index, :create, :update, :destroy]
  resources :categories, only: [:index]
  resources :skills, only: [:index]
  resources :user_skills, only: [:create, :destroy]
  resources :places do
    resources :availabilities, only: [:index, :create, :edit, :update, :destroy]
  end
  resources :connections, only: [:index, :create, :update, :show] do
    resources :meetings, only: [:create, :show, :update] do
      resources :places, only: [:index, :show, :update]
      resources :messages, only: [:create]
    end
  end

end
