class Contenticus::Admin::FilesController < ApplicationController
  layout "contenticus/admin"

  def index
    @files = Contenticus::File.all
  end

  def new
    @file = Contenticus::File.new
  end

  def create
    @file = Contenticus::File.create(file_params)
    redirect_to contenticus_admin_files_path    
  end

  private

  def file_params
    params[:contenticus_file].permit!
  end

end