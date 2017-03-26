Contenticus::Application.routes.draw do

  contenticus_route :cms_admin

  scope :module => :contenticus, :as => :contenticus do
    get '/:format' => 'pages#show', :as => 'render_page', :path => "(*cms_path)"
  end

end
