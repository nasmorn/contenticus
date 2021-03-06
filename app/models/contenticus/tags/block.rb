module Contenticus
module Tags
class Block < Base

  attr_reader :min, :max, :wrap_in_admin

  def initialize(values, key:, layout:, name: nil, comment: nil, parent: nil, toggle_published: false, open_by_default: false, wrap_in_admin: true)
    super values, key: key, name: name, comment: comment, parent: parent
    @values ||= {}
    @layout_name = layout
    @toggle_published = toggle_published
    @open_by_default = open_by_default
    @wrap_in_admin = wrap_in_admin
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
      published_tag.update_attributes(@values.delete('contenticus-published'))
    end
    tags.each do |tag|
      tag.update_attributes(@values.fetch(tag.key))
    end
  # rescue
  #   raise "#{@values.inspect} #{key}"
  end

  def serialize
    {
      key => published_tag.serialize.merge(tags.map(&:serialize).inject(&:merge))
    }
  end

  def frontend_partial
    layout.frontend_path
  end

  def published_tag
    @published_tag ||= Contenticus::Tags::Boolean.new(@values.fetch('contenticus-published', '1'), key: 'contenticus-published', hidden: true)
  end

  def published?
    published_tag.true?
  end

  def toggle_published?
    @toggle_published
  end

  def open_by_default?
    @open_by_default
  end

end
end
end
