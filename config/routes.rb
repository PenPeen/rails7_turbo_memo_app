Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "memos#index"
  resources :memos, only: [:index, :create, :edit, :update, :destroy]

  # モーダル
  get 'memos/confirm/:id', to: 'memos#confirm', as: 'memos_confirm'
  # 検索
  get 'memos/search', to: 'memos#search'
end
