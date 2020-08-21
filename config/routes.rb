Rails.application.routes.draw do
  
  # ルートページのルーティング
  root 'static_pages#home'
  
  # 静的なページのルーティング
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  
end
