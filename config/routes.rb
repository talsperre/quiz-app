Rails.application.routes.draw do
  get 'static_pages/home'

  get 'static_pages/about'

  get 'quizzes/new'

  get 'games/new'
  get 'sessions/new'
  root 'static_pages#home'
  get  '/about',   to: 'static_pages#about'
  get  '/home',   to: 'static_pages#home'
  get  '/scoreboard', to: 'static_pages#leaderboard'
  get  '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'play(/:id)', to: 'games#play', as: :play
  post 'state_update/', to: 'games#state_update', as: :state_update
  get 'show_leaderboard/:id/:row_id', to: 'games#show_leaderboard', as: :leaderboard
  get 'quizzes/show/:id/', to: 'quizzes#show_all_quizzes', as: :show_all_quizzes
  get 'subcategories/show/:id', to: 'subcategories#show_all_subcategories', as: :show_all_subcategories
  get 'users/show_past_history', to: 'users#show_past_history', as: :show_past_history
  get 'games/show_correct', to: 'games#show_correct', as: :show_correct
  get 'auth/:provider/callback', to: 'sessions#extauth'
  get 'auth/google_oauth2', as: :auth_google
  get 'auth/failure', to: 'static_pages#home'
  post 'play/show_correct_options', to: 'games#show_two_options', as: :show_two_options
  post 'play/audience_poll', to: 'games#audience_poll', as: :audience_poll
  resources :users
  resources :questions,     only: [:create, :new, :index, :destroy, :edit, :update]
  resources :categories,    only: [:create, :new, :index, :destroy, :edit, :update]
  resources :subcategories, only: [:create, :new, :index, :destroy, :edit, :update]
  resources :questions,     only: [:create, :new, :index, :destroy, :edit, :update]
  resources :quizzes,       only: [:create, :new, :index, :destroy, :edit, :update]
end
