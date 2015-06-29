class Contenticus::PagesController < ApplicationController

  def show
    page = Contenticus::Slug.find_by(full_path: "/#{params[:cms_path]}").sluggable

    render cms_page: page
  end

end