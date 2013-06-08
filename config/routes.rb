TrelloTrack::Application.routes.draw do

  resources :users

  root 'reporting#daily'

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/login', to: 'sessions#new', as: :login
  get '/logout', to: 'sessions#destroy', as: :logout

  get 'reporting' => 'reporting#daily'
  get 'reporting/daily(/:year/:month/:day)' => 'reporting#daily', as: :daily
  get 'reporting/weekly(/:year/:week)' => 'reporting#weekly', as: :weekly
  get 'reporting/monthly(/:year/:month)' => 'reporting#monthly', as: :monthly
  get 'reporting/custom/from(/:year_from/:month_from/:day_from)/to(/:year_to/:month_to/:day_to)' => 'reporting#custom', as: :custom

  get 'settings' => 'settings#index', as: :settings

  resources :users

end