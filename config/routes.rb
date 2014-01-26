Cems::Application.routes.draw do
  resources :template_questions

  namespace :api, defaults: { format: :json } do
    resources :personal_engagement_lists, only: [:new, :create, :edit, :update] do
      get '/lists' => 'personal_engagement_lists#pels_for_current_user', on: :collection
    end
  end

  get '/dashboard' => 'home#index'
  
  get '/templates/:path.html' => 'templates#template', :constraints => { :path => /.+/ }

  get '/signout' => "application#signout"
  get '/health'   => "application#health"

  root 'home#index'
end
