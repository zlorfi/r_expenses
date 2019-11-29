Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get 'login', to: 'users/sessions#new'
    get 'logout', to: 'users/sessions#destroy'
    get 'users/edit', to: 'devise/registrations#edit', as: 'edit_user_registration'
    patch 'users', to: 'devise/registrations#update', as: 'user_registration'
  end

  resources :expenses do
    collection do
      get 'month', as: 'monthly'
      get 'year', as: 'annual'
    end
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      namespace :charts do
        get :by_month
        get :linechart_by_year
        get :barchart_by_year
      end
    end
  end

  root 'expenses#new'
end
