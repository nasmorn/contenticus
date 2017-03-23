module Contenticus
module Tags
class Base

  attr_reader :key, :name, :comment

  def initialize(values, key:, name: nil, comment: nil)
    @key = key
    @name = name ? name : @key.capitalize
    @comment = comment
    @values = values
  end

  def type
    self.class.name.underscore.split('/').last
  end

  def self.instantiate(fields, key, options_from_layout)
    options = {key: key}
    options = if options_from_layout.kind_of?(String)
     {type: options_from_layout}.merge(options)
    else
      options.merge(options_from_layout)
    end.with_indifferent_access

    ("Contenticus::Tags::" + options.delete(:type).classify).constantize.new(fields[options.fetch(:key)], options.symbolize_keys)
  rescue
    raise "Key: #{key} - options: #{options_from_layout}"
  end

  def value
    if @values.kind_of?(Hash)
      if @values.has_key?(:value) && @values.keys.count == 1
        @values.fetch(:value)
      end
    else
      @values
    end
  end

  def values
    @values
  end

  def update_attributes(params)
    @values = params.fetch(:value)
  end

  def serialize
    {
      key => @values
    }
  end

  def frontend_partial
    "/contenticus/tags/#{type}"
  end

  # Called by bootstrap form

  def self.validators_on(arg)
    []
  end

  def self.model_name
    'Base'
  end

end
end
end