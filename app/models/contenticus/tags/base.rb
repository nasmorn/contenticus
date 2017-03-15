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

  def self.instantiate(fields, class_name, options)
    options = if options.kind_of?(String)
      {key: options}
    else
      options
    end.with_indifferent_access
    ("Contenticus::Tags::" + class_name.classify).constantize.new(fields[options.fetch(:key)], options.symbolize_keys)
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