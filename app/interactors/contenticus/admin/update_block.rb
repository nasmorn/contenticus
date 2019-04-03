module Contenticus
module Admin
class UpdateBlock < ::Contenticus::Interactor

  def initialize(block_id:, params:)
    @block = ::Contenticus::Block.find(block_id)
    @params = params
  end

  def call
    if @params[:layout].present?
      @block.layout = @params.fetch(:layout)
    end

    @tags = @block.tags.map do |tag|
      # We might just want to update some of the tags
      if @params.to_h.has_key?(tag.key)
        tag.update_attributes(@params.fetch(tag.key))
      end
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
