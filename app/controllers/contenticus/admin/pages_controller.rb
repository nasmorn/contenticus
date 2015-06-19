class Contenticus::Admin::PagesController < ApplicationController
  layout "contenticus/admin"

  def new
    build_page
  end

  def create
    x
  end

  private

  def build_page
    @page = Contenticus::Page.new
    @page.master_block = Contenticus::Block.from_layout(Contenticus::PageLayout.available.first, true)
  end

end