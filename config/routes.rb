DataEngineering::Application.routes.draw do
  resources :raw_transactions
  root to: 'raw_transactions#new'
end
