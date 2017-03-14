Contenticus::Application.routes.draw do

  scope :module => :contenticus, :as => :contenticus do
    namespace :admin, as: :admin do
      resources :pages do
        put :reorder,         :on => :collection
      end
      resources :blocks
      resources :snippets
      resources :images
    end

    get '/:format' => 'pages#show', :as => 'render_page', :path => "(*cms_path)"
  end

end
