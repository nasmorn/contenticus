module Contenticus
module Admin
class UpdateSnippet < ::Contenticus::Interactor

  def initialize(id:, tag_params:)
    @snippet = ::Contenticus::Snippet.find(id)
    @params = tag_params
  end

  def call
    tags = UpdateBlock.call(block_id: @snippet.block.id, params: @params)
    return @snippet, tags
  end

end
end
end