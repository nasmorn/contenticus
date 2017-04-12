module Contenticus
module Admin
class DestroyPage < ::Contenticus::Interactor

  def initialize(page_id:)
    @page = Page.find(page_id)
  end

  def call
    return false if @page.slug.children.any?
    ::Contenticus::Page.transaction do
      @page.block.destroy
      @page.meta.destroy
      @page.destroy
      @page.slug.destroy
    end
  end

end
end
end
