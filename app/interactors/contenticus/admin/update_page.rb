module Contenticus
module Admin
class UpdatePage < ::Contenticus::Interactor

  def initialize(id:, tag_params:)
    @page = ::Contenticus::Page.find(id)
    @params = tag_params
  end

  def call
    UpdateBlock.call(block_id: @page.meta.id, params: @params.fetch(:meta))
    UpdateBlock.call(block_id: @page.block.id, params: @params.fetch(:block))
    return @page
  end

end
end
end
