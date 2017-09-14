Rails.application.routes.draw do
  root to: 'pages#home'
  get 'search' => 'pages#search'
  post 'search' => 'pages#scrap'
  get 'results' => 'pages#results'
  resources :wines
end
