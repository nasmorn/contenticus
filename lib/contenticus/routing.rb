class ActionDispatch::Routing::Mapper
  def contenticus_route_cms_admin(options = {})
    options[:path] ||= 'admin'

    scope :module => :contenticus, :as => :contenticus do
      namespace :admin, as: :admin do
        resources :pages do
          put :reorder,         :on => :collection
        end
        resources :blocks do
          put :toggle, :on => :member
        end
        resources :snippets
        resources :images
        get '/' => redirect('/admin/pages')
      end
    end
  end

  def contenticus_route_cms_sitemap(option = {})
    scope module: :contenticus, as: :contenticus do
      get "sitemap" => "sitemap#index"
    end
  end

  def contenticus_route_cms(option = {})
    scope :module => :contenticus, :as => :contenticus do
      get '(*cms_path)' => 'pages#show', :as => 'render_page', action: '/:format'
    end
  end

  def contenticus_route(identifier, options = {})
    send("contenticus_route_#{identifier}", options)
  end
end
