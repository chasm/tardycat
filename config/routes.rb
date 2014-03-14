P2::Application.routes.draw do
  root 'site#index'

  # Log in/out
  get    'login'  => 'session#new', as: :login_form
  post   'login'  => 'session#create', as: :log_in
  delete 'logout' => 'session#destroy', as: :log_out

  # Password reset
  get   'reset/:code' => 'password#edit', as: :password_reset_form
  patch 'reset/:code' => 'password#update', as: :reset_password

  get 'privacy' => 'site#privacy'
  get 'terms'   => 'site#terms'
end
