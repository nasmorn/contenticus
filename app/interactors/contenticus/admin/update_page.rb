module Contenticus
module Admin
class UpdatePage < ::Contenticus::Interactor

  def initialize(id:, tag_params:)
    @page = ::Contenticus::Page.find(id)
    @params = tag_params
  end

  def call
    tags = UpdateBlock.call(block_id: @page.block.id, params: @params)
    return @page, tags
  end

end
end
end