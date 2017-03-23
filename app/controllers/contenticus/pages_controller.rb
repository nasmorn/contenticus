class Contenticus::PagesController < ApplicationController

  def show
    page = Contenticus::Slug.find_by(full_path: "/#{params[:cms_path]}").sluggable

    @block = page.master_block
    render "contenticus/layouts/#{page.master_block.layout}/_main"
  end

end