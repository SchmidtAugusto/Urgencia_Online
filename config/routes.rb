Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :hospitals, except: %i[index] do
    resources :appointments, only: %i[new create destroy]
  end

  patch "appointments/:id", to: "appointments#done", as: "appointment_done"

  resources :appointments, only: %i[index show update]

  resources :users, only: %i[edit update]
  resources :medical_records, only: %i[create update]
  resources :plan_details, only: %i[create update]

  get :help, to: "pages#help"

  get :admin, to: "pages#admin"

  get :account_details, to: "pages#account_details"
  get :plan_details, to: "pages#plan_details"
  get :medical_data, to: "pages#medical_data"
end
