class Contenticus::PagesController < ApplicationController

  def show
    page = Contenticus::Slug.find_by(full_path: "/#{params[:cms_path]}").sluggable

    @block = page.block
    render "contenticus/layouts/#{@block.layout}/_main"
  end

end