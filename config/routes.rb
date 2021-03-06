TrelloTrack::Application.routes.draw do

  resources :projects, :only => [:index, :edit, :update, :destroy]
  resources :users, :only => [:index, :edit, :update, :destroy]

  root 'reporting#daily'

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/login', to: 'sessions#new', as: :login
  get '/logout', to: 'sessions#destroy', as: :logout

  get '/reporting' => 'reporting#daily'
  get '/reporting/daily(/:year/:month/:day)' => 'reporting#daily', as: :daily
  get '/reporting/weekly(/:year/:week)' => 'reporting#weekly', as: :weekly
  get '/reporting/monthly(/:year/:month)' => 'reporting#monthly', as: :monthly
  get '/reporting/custom/from(/:year_from/:month_from/:day_from)/to(/:year_to/:month_to/:day_to)' => 'reporting#custom', as: :custom

  get '/settings' => 'settings#index', as: :settings

  get '/extensions' => 'tasks#extensions', as: :extensions
  get '/account' => 'users#account', as: :account

  resources :tasks, :except => [:index, :show] do
    member do
      post 'stop'
      post 'continue'
    end
  end

  namespace :api, defaults: {format: 'json'} do
    get '/timer' => 'timer#in_progress'
    get '/timer/last' => 'timer#last_task'
    post '/timer/create' => 'timer#create'
    post '/timer/stop' => 'timer#stop'
    post '/timer/continue' => 'timer#continue'
  end


end
