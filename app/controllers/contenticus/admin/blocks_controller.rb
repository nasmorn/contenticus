class Contenticus::Admin::BlocksController < Contenticus::Admin::BaseController

  def toggle
    @block = Contenticus::Block.find(params[:id])
    @block.toggle!(:is_published)
    redirect_to contenticus_admin_pages_path
  end

  def index
    @blocks = Contenticus::Block.order(:blockable_type, :blockable_id).includes(:blockable)
  end

  def show
    @block = Contenticus::Block.find(params[:id])
  end

end
