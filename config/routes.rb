Rails.application.routes.draw do

  get "/search", to: 'searches#index'

  mount Simplec::Engine => "/"

  scope constraints: { subdomain: 'admin' } do
    root 'static#dashboard'

    scope module: 'admin' do
      # Custom related
      resources :articles,
        only: %w(index new create edit update destroy)
      resources :alerts,
        only: %w(index new create edit update destroy)

      # CMS Related
      resources :subdomains,
        only: %w(index new create edit update destroy)
      scope as: 'admin' do
        resources :pages,
          only: %w(index new create edit update destroy)
      end
      resources :documents,
        only: %w(index new create edit update destroy)
      resources :document_sets, path: 'document-sets',
        only: %w(index new create edit update destroy)
      resources :embedded_images, path: 'embedded-images',
        only: %w(create)
    end

    resources :users,
      only: %w(new create edit update index destroy)
    resource :session,
      only: %w(new create destroy)
  end
end
