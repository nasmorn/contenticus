module Contenticus
module Tags
class Block < Base

  attr_reader :min, :max

  def initialize(values, key:, layout:, name: nil, comment: nil)
    super values, key: key, name: name, comment: comment
    @values ||= {}
    @layout_name = layout
  end

  def tags
    layout.tags
  end

  def layout
    Contenticus::Layout.new(@layout_name, @values)
  end

  def update_attributes(params)
    @values = params.permit!
    tags.each do |tag|
      tag.update_attributes(@values.fetch(tag.key))
    end
  end

  def serialize
    {
      key => tags.map(&:serialize).inject(:merge)
    }
  end

end
end
end