HackTheBudget::Application.routes.draw do
  resources :home, only: :index
  resources :budget_line_items, only: :index
  root to: 'home#index'
end
