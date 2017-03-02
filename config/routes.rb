Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
  end

  resources :expenses do
    collection do
      get 'overview'#, constraints: lambda { |req| req.format == :html }
    end
  end

  root 'expenses#new'
end
