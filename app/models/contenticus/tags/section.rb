module Contenticus
module Tags
class Section < Base

  attr_reader :min, :max

  def initialize(values, key:, name: nil, comment: nil, min: nil, max: nil)
    super values, key: key, name: name, comment: comment
    @min = min
    @max = max
    @values ||= {}
  end

  def tags
    layout.tags
  end

  def layout
    Contenticus::BlockLayout.new(layout_name, @values)
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

  private

  def layout_name
    @key
  end

end
end
end