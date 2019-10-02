module Contenticus
module Tags
class Base

  attr_reader :key, :name, :comment

  def initialize(values, key:, name: nil, comment: nil, parent: nil)
    @key = key
    @name = name ? name : @key.capitalize
    @comment = comment
    @values = values
    @parent = parent
  end

  def type
    self.class.to_s.underscore.split('/').last
  end

  def self.instantiate(fields, key, options_from_layout)
    options = {key: key}
    options = if options_from_layout.kind_of?(String)
     {type: options_from_layout}.merge(options)
    else
      options.merge(options_from_layout)
    end.with_indifferent_access

    ("Contenticus::Tags::" + options.delete(:type).classify).constantize.new(fields[options.fetch(:key)], options.symbolize_keys)
  #rescue
    #raise "Key: #{key} - options: #{options_from_layout} - fields: #{fields}"
  end

  def value
    if @values.kind_of?(Hash)
      if @values.with_indifferent_access.has_key?(:value)
        @values.with_indifferent_access.fetch(:value)
      end
    else
      @values
    end
  end

  def values
    @values
  end

  def update_attributes(params)
    @values = params
  end

  def serialize
    {
      key => @values
    }
  end

  def frontend_partial
    "/contenticus/tags/#{type}"
  end

  def published?
    true
  end

  def toggle_published?
    false
  end

  # Called by bootstrap form

  def self.validators_on(arg)
    []
  end

  def self.model_name
    Base
  end

  def keychain
    if @parent
      [@parent.key] + [key]
    else
      [key]
    end
  end

  def dom_id
    "tag-" + keychain.join('-')
  end

  def collectible?
    @parent && @parent.collectible?
  end

  def published?
    true
  end

  def toggle_published?
    false
  end

  def open_by_default?
    true
  end

end
end
end
