module Contenticus
module Admin
class CreateSnippet < ::Contenticus::Interactor

  def initialize(label:, key:, block_params:)
    @label = label
    @key = key
    @block_params = block_params
  end

  def call
    snippet = ::Contenticus::Snippet.new(label: @label, key: @key)
    snippet.build_block(@block_params)
    snippet.save
    snippet
  end

end
end
end