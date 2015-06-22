class Contenticus::Admin::PagesController < ApplicationController
  layout "contenticus/admin"

  def index
    @pages = Contenticus::Slug.where(sluggable_type: "Contenticus::Page").includes(sluggable: :master_block).arrange(order: "position")
  end

  def new
    build_page
  end

  def create
    @page = Contenticus::Page.create(page_params)
    redirect_to contenticus_admin_pages_path
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