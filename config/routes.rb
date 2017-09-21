Rails.application.routes.draw do
  root to: 'pages#home'
  get 'search' => 'scrapers#search'
  get 'show_wine' => 'scrapers#show_wine'
  get 'year' => 'scrapers#year'
  post 'save' => 'scrapers#save'
  resources :wines
end
