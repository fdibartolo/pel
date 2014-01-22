Cems::Application.routes.draw do
  resources :template_questions

  get '/lists'       => 'personal_engagement_lists#pels_for_current_user', defaults: { format: :json }
  get '/new'         => 'personal_engagement_lists#new', defaults: { format: :json }
  post '/create'     => 'personal_engagement_lists#create', defaults: { format: :json }
  get '/edit/:id'    => 'personal_engagement_lists#edit', defaults: { format: :json }
  match '/lists/:id' => 'personal_engagement_lists#update', defaults: { format: :json }, via: [:patch, :put]

  get '/dashboard' => 'home#index'
  
  get '/templates/:path.html' => 'templates#template', :constraints => { :path => /.+/ }

  get '/signout' => "application#signout"
  get '/health'   => "application#health"

  root 'home#index'
end
