module Contenticus
module Admin
class CreatePage < ::Contenticus::Interactor

  def initialize(slug_params:, block_params:)
    @slug_params = slug_params
    @block_params = block_params
  end

  def call
    page = ::Contenticus::Page.new
    page.build_slug(@slug_params)
    page.build_block(@block_params)
    page.save
    page
  end

end
end
end