module Contenticus
module Admin
class UpdateBlock < ::Contenticus::Interactor

  def initialize(block_id:, params:)
    @block = ::Contenticus::Block.find(block_id)
    @params = params
  end

  def call
    @tags = @block.tags.map do |tag|
      tag.update_attributes(@params.fetch(tag.key))
      tag
    end

    @block.fields = serialize_tags
    @block.save!

    return @tags
  end

  private

  def serialize_tags
    @tags.map(&:serialize).inject(:merge)
  end

end
end
end