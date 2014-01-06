Cems::Application.routes.draw do
  get '/lists' => 'personal_engagement_lists#pels_for_current_user', defaults: { format: :json }
  
  get '/dashboard' => 'home#index'
  get '/templates/:path.html' => 'templates#template', :constraints => { :path => /.+/ }

  get '/signout' => "application#signout"

  root 'home#index'
end
