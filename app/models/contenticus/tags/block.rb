module Contenticus
module Tags
class Block < Base

  attr_reader :min, :max

  def initialize(values, key:, layout:, name: nil, comment: nil, toggle_published: false)
    super values, key: key, name: name, comment: comment
    @values ||= {}
    @layout_name = layout
    @toggle_published = toggle_published
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
    @values = params
    if @values.has_key?('contenticus-published')
      published_tag.update_attributes(@values.fetch('contenticus-published'))
      @values.delete('contenticus-published')
    end
    tags.each do |tag|
      tag.update_attributes(@values.fetch(tag.key))
    end
  rescue
    raise "#{@values.inspect} #{key}"
  end

  def serialize
    {
      key =>  published_tag.serialize.merge(tags.map(&:serialize).inject(&:merge))
    }
  end

  def frontend_partial
    layout.frontend_path
  end

  def published_tag
    @published_tag ||= Contenticus::Tags::Boolean.new(@values.fetch('contenticus-published', '1'), key: 'contenticus-published', hidden: false)
  end

  def published?
    published_tag.true?
  end

  def toggle_published?
    @toggle_published
  end

end
end
end
