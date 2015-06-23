Contenticus::Application.routes.draw do

  scope :module => :contenticus, :as => :contenticus do
    namespace :admin, as: :admin do
      resources :pages do
        put :reorder,         :on => :collection
      end
    end
  end

  root "contenticus/pages#index"

end
