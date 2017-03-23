module Contenticus
module Tags
class Block < Base

  attr_reader :min, :max

  def initialize(values, key:, layout:, name: nil, comment: nil)
    super values, key: key, name: name, comment: comment
    @values ||= {}
    @layout_name = layout
  end

  def tag(key)
    tags.find {|tag| tag.key == key.to_s}
  end

  def tags
    layout.tags
  end

  def layout
    @layout ||= Contenticus::Layout.new(@layout_name, @values)
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

  def frontend_partial
    layout.frontend_path
  end

end
end
end