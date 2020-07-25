module Contenticus
module Tags
class Collection < Base

  attr_reader :min, :max

  def initialize(values, key:, tag:, name: nil, comment: nil, min: 0, max: nil, parent: nil)
    super values, key: key, name: name, comment: comment
    @min = min
    @max = max
    @values ||= {}
    @options = tag.with_indifferent_access
    @type = @options.fetch(:type)
    @parent = parent
  end

  def tag(key)
    tags.find {|tag| tag.key == key.to_s}
  end

  def tags
    new_tags = []
    collectible_values.each do |k,v|
      new_tags << instantiate({k => v}, k)
    end
    if new_tags.count < @min
      ((new_tags.count + 1)..@min).to_a.each do |i|
        new_tags << instantiate({}, i.to_s)
      end
    end
    new_tags
  end

  def instantiate(values, new_key)
    Contenticus::Tags::Base.instantiate(values, @type, @options.merge(key: new_key, name: @name, parent: self))
  end

  def update_attributes(params)
    @values = params
    @values.delete('contenticus-additional')
    published_tag.update_attributes(@values.fetch('contenticus-published'))
    @values.delete('contenticus-published')
    tags.each do |tag|
      tag.update_attributes(@values.fetch(tag.key))
    end
  end

  def serialize
    serialized_tags = tags.map(&:serialize).inject({}, &:merge)
    {
      key => published_tag.serialize.merge(serialized_tags)
    }
  end

  def add_tag
    instantiate({}, 'contenticus-additional')
  end

  def published_tag
    @published_tag ||= Contenticus::Tags::Boolean.new(@values.fetch('contenticus-published', '1'), key: 'contenticus-published', hidden: true)
  end

  def published?
    published_tag.true?
  end

  def collectible_values
    @values.select {|k,v| k =~ /\A\d+/}
  end

  def collection_layout
    return unless @options.has_key?(:layout)
    Contenticus::Layout.new(@options.fetch(:layout), {}).frontend_path('collection_wrapper')
  end

  def count
    tags.length
  end

  def toggle_published?
    true
  end

  def collectible?
    true
  end
end
end
end
