module Contenticus
module Admin
class SnippetDestroy < ::Contenticus::Interactor

  def initialize(id)
    @snippet = Snippet.find(id)
  end

  def call
    ::Contenticus::Snippet.transaction do
      @snippet.block.destroy
      @snippet.destroy
    end
  end

end
end
end
