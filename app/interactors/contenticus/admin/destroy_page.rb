module Contenticus
module Admin
class DestroyPage < ::Contenticus::Interactor

  def initialize(page_id:)
    @page = Page.find(page_id)
  end

  def call
    # Destroy blocks
    ::Contenticus::Page.transaction do
      @page.block.destroy
      @page.destroy
    end
  end

end
end
end