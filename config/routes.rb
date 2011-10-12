Cenci3::Application.routes.draw do
  resources :enrollments
  root :to => 'enrollments#new'
end
