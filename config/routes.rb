Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
    get 'users/edit', to: 'devise/registrations#edit', as: 'edit_user_registration'
    patch 'users', to: 'devise/registrations#update', as: 'user_registration'
  end

  resources :expenses do
    collection do
      get 'overview'#, constraints: lambda { |req| req.format == :html }
    end
  end

  root 'expenses#new'
end
