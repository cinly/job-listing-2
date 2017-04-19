Rails.application.routes.draw do
  
  devise_for :users, :controllers => { :registrations => "users/registrations" }

  resources :jobs do
    resources :resumes
  end

  namespace :admin do
    resources :jobs do
      member do
        post :publish
        post :hide
      end
      resources :resumes
    end
  end

  namespace :account do
    resources :jobs
  end

  root 'welcome#index'
end
