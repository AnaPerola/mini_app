Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :tasks do 
    post 'change_privacy', on: :member
    get 'private_page', on: :member
  end

  resources :tasks_report, only: %i[index] 
  get 'report', to: 'tasks_report#report'

  resources :profiles, only: %i[show new create update edit] do
    get 'private_page', on: :member
    post 'change_privacy', on: :member
    resources :comments, only: %i[index]
  end

  resources :pluses, only: %i[create destroy]
  resources :minuses, only: %i[create destroy]
end
