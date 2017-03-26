class Contenticus::PagesController < ApplicationController

  def show
    page = Contenticus::Slug.find_by(full_path: "/#{params[:cms_path]}").sluggable
    @block = page.block

    if page.redirect?
      redirect_to page.redirect_target
    else
      render @block.frontend_layout
    end
  end

end