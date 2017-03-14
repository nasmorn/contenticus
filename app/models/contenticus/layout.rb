class Contenticus::Layout

  def initialize(identifier, fields, type)
    raise "No Identifier given" if identifier.blank?
    @identifier = identifier
    @type = type
    @fields = fields
  end

  def path
    "layouts/#{@type}/#{@identifier}"
  end

  # List of available application layouts
  def self.available_for(type)
    sub_path = "app/views/contenticus/layouts/#{type}"
    Dir.glob(File.expand_path(sub_path + '/*/', Rails.root)).collect do |filename|
      filename.gsub!("#{File.expand_path(sub_path, Rails.root)}/", '')
    end.compact.sort
  end

  def tags
   parse 'app/views/contenticus/' + path + "/tags.yml"
  end

  def parse(path)
    tags = []
    YAML.load(File.read(File.expand_path(path, Rails.root))).each do |k,v|
      tags << ::Contenticus::Tags::Base.instantiate(@fields,k,v)
    end
    tags
  end

end