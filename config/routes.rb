Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
  end

  resources :expenses do
    collection do
      get 'overview'
    end
  end

  root 'expenses#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
