class Contenticus::Admin::ImagesController < ApplicationController
  layout "contenticus/admin"

  def index
    @images = Contenticus::Image.all
  end

  def new
    @image = Contenticus::Image.new
  end

  def create
    @image = Contenticus::Image.create(image_params)
    redirect_to contenticus_admin_images_path    
  end

  private

  def image_params
    params[:contenticus_image].permit!
  end

end