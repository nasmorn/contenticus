module Contenticus
module Tags
class Mixed < Base
  class MixedTagDecorator < SimpleDelegator
    def initialize(object, mixed_key)
      super(object)
      @mixed_key = mixed_key
    end

    def mixed_key
      @mixed_key
    end

    def mixed_key=(value)
    end

    def collectible?
      true
    end
  end

  def initialize(values, key:, tags:, name: nil, comment: nil)
    super values, key: key, name: name, comment: comment
    @values ||= {}
    @options = tags
  end

  def keys
    @options.keys
  end

  def options_for(key)
    @options[key.to_s].with_indifferent_access
  end

  def tag(key)
    tags.find {|tag| tag.key == key.to_s}
  end

  def tags
    collectible_values.map do |k,v|
      instantiate(v.with_indifferent_access[:mixed_key], {k => v}, k)
    end
  end

  def instantiate(key, values, new_key)
    raise "Key cannot be nil" unless key
    type = options_for(key).fetch(:type)
    MixedTagDecorator.new(
      Contenticus::Tags::Base.instantiate(values, type, options_for(key).merge(key: new_key, parent: self)),
      key)
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
    serialized_tags = tags.map do |tag|
      s = tag.serialize
      s.values.first.merge!(mixed_key: tag.mixed_key)
      s
    end.inject({}, &:merge)
    {
      key => published_tag.serialize.merge(serialized_tags)
    }
  end

  def add_tag(key)
    instantiate(key, {}, 'contenticus-additional')
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

end
end
end
