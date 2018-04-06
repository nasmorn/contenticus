module Contenticus
module Admin
class ChangeTemplate < ::Contenticus::Interactor

  def initialize(block_id:, template:)
    @block = ::Contenticus::Block.find(block_id)
    @template = template
  end

  def call
    @block.template = @template
    @block.save!
  end

end
end
end
