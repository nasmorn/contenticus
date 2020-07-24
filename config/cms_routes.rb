# frozen_string_literal: true

Contenticus::Application.routes.draw do
  contenticus_route :cms_admin

  scope module: :contenticus, as: :contenticus do
    get "sitemap" => "sitemap#index"
    get "(*cms_path)" => "pages#show", :as => :render_page, :action => "/:format"
  end
end
