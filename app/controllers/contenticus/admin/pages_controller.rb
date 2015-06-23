class Contenticus::Admin::PagesController < ApplicationController
  layout "contenticus/admin"

  def index
    @pages = Contenticus::Slug.where(sluggable_type: "Contenticus::Page").includes(sluggable: :master_block).arrange(order: "position")
  end

  def new
    build_page
    @page.slug.parent_id = params[:parent_id] if params[:parent_id]
  end

  def create
    @page = Contenticus::Page.create(page_params)
    redirect_to contenticus_admin_pages_path
  end

  def edit
    @page = Contenticus::Page.find params[:id]
  end

  def update
    @page = Contenticus::Page.find(params[:id])
    if @page.update_attributes(page_params) && params[:close_after_save] == "close"
      redirect_to contenticus_admin_pages_path
    else
      render 'edit'
    end
  end

  def reorder
    (params[:contenticus_slug] || []).each_with_index do |id, index|
      ::Contenticus::Slug.where(:id => id).update_all(:position => index)
    end
    render :nothing => true
  end  

  private

  def page_params
    params[:contenticus_page].permit!
  end

  def build_page
    @page = Contenticus::Page.new
    @page.master_block = Contenticus::Block.from_layout(Contenticus::PageLayout.available.first, true)
    @page.build_slug
  end

end