Cenci3::Application.routes.draw do
  delete 'logout' => 'sessions#destroy', :as => 'logout'
  post 'login' => 'sessions#create', :as => 'login'
  resources :enrollments
  resources :accounts do
    post 'approve' => 'accounts#approve', :as => 'approval'
    post 'register_pin' => 'accounts#register_pin', :as => 'register_pin'
  end
  resources :agents
  root :to => 'dashboards#index'
end
