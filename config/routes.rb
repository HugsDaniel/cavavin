Rails.application.routes.draw do
  root to: 'pages#home'
  get 'search' => 'scrapers#search'
  get 'show' => 'scrapers#show'
  post 'save' => 'scrapers#save'
  resources :wines
end
