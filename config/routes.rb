Cems::Application.routes.draw do
  get '/dashboard' => 'home#index'
  get '/templates/:path.html' => 'templates#template', :constraints => { :path => /.+/  }

  root 'home#index'
end
