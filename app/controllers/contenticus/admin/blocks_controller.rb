class Contenticus::Admin::BlocksController < ApplicationController

  def new
    @block = Contenticus::Block.from_layout(params[:layout])
    @block.section = params[:section]
  end

end