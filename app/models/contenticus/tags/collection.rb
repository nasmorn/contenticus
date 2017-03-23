module Contenticus
module Tags
class Collection < Base

  attr_reader :min, :max

  def initialize(values, key:, tag:, name: nil, comment: nil, min: 0, max: nil)
    super values, key: key, name: name, comment: comment
    @min = min
    @max = max
    @values ||= {}
    @type = tag.keys.first
    @options = tag[@type]
  end

  def tags
    new_tags = []
    @values.each do |k,v|
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
    Contenticus::Tags::Base.instantiate(values, @type, @options.merge(key: new_key, name: @name))
  end

  def update_attributes(params)
    @values = params.permit!
    @values.delete('additional')
    tags.each do |tag|
      tag.update_attributes(@values.fetch(tag.key))
    end
  end

  def serialize
    {
      key => tags.map(&:serialize).inject(&:merge)
    }
  end

  def add_tag
    instantiate({}, 'additional')
  end

end
end
end