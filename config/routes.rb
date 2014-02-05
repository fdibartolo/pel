Cems::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  resources :template_questions

  namespace :api, defaults: { format: :json } do
    resources :personal_engagement_lists, only: [:new, :create, :edit, :update] do
      get '/lists' => 'personal_engagement_lists#pels_for_current_user', on: :collection
    end

    resources :requests, only: [:new, :create, :update] do
      get 'all' => 'requests#all_for_current_user', on: :collection
    end
  end

  get '/templates/:path.html' => 'templates#template', :constraints => { :path => /.+/ }

  get '/signout' => "application#signout"
  get '/health'   => "application#health"

  root 'home#index'
end
