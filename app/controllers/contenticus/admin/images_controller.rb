class Contenticus::Admin::ImagesController < Contenticus::Admin::BaseController
  layout "contenticus/admin"

  def index
    @filter = params[:filter]
    @filter ||= 'general'
    @images = if @filter == 'general'
      Contenticus::Image.where(block_id: nil)
    elsif @filter =~ /\A\d+/
      Contenticus::Image.where(block_id: @filter)
    end
    @images = Contenticus::Image.all
  end

  def new
    @image = Contenticus::Image.new
  end

  def create
    @image = Contenticus::Image.create(image_params)
    if @image.persisted?
      redirect_to contenticus_admin_images_path
    else
      render 'new'
    end
  end

  def edit
    @image = Contenticus::Image.find(params[:id])
  end

  def update
    @image = Contenticus::Image.find(params[:id])
    @image.update_attributes(image_params)
    redirect_to contenticus_admin_images_path
  end

  private

  def image_params
    params[:contenticus_image].permit!
  end

end
