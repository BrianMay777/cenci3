Cenci3::Application.routes.draw do
  delete "logout" => "sessions#destroy", :as => "logout"
  post "login" => "sessions#create", :as => "login"
  resources :enrollments
  resources :accounts
  root :to => 'enrollments#new'
end
