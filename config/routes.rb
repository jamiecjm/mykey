Rails.application.routes.draw do
  resources :passwords, controller: "passwords", only: [:create, :new]
  get "/passwords/change" => "users#change_password"
  post "/passwords/update" => "users#update_password"
  resource :session, controller: "sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "passwords",
      only: [:create, :edit, :update]
  end
  resources :users, controller: "users"
  get '/first_login' => "users#first_login"
  post '/first_update' => "users#first_update"

  root "pages#index"
  get "/pages/account" => "pages#account"
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects, controller: "projects"
  get "/user_projects" => "projects#user"
  get "/project/:project_id/units" => "projects#units"
  resources :units, controller: "units"
  get "/units/dynamic_options/:id" => "units#dynamic_options"
end
