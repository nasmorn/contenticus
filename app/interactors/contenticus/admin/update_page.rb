module Contenticus
module Admin
class UpdatePage < ::Contenticus::Interactor

  def initialize(page_id:, tag_params:)
    @page = ::Contenticus::Page.find(page_id)
    @params = tag_params
  end

  def call
    tags = UpdateBlock.call(block_id: @page.master_block.id, params: @params)
    return @page, tags
  end

end
end
end