class Contenticus::Admin::BlocksController < ApplicationController

  def toggle
    @block = Contenticus::Block.find(params[:id])
    @block.toggle!(:is_published)
    redirect_to contenticus_admin_pages_path
  end

end