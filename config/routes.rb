Cems::Application.routes.draw do
  resources :template_questions

  get '/lists' => 'personal_engagement_lists#pels_for_current_user', defaults: { format: :json }
  get '/new' => 'personal_engagement_lists#new', defaults: { format: :json }
  post '/create' => 'personal_engagement_lists#create', defaults: { format: :json }
  
  get '/dashboard' => 'home#index'
  get '/templates/:path.html' => 'templates#template', :constraints => { :path => /.+/ }

  get '/signout' => "application#signout"

  root 'home#index'
end
