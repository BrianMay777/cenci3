Cenci3::Application.routes.draw do
  resources :enrollments
  resources :accounts
  root :to => 'enrollments#new'
end
