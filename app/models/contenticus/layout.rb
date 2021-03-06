class Contenticus::Layout

  def initialize(identifier, fields)
    raise "No Identifier given" if identifier.blank?
    @identifier = identifier
    @fields = fields
  end

  def tags
    return [] if redirect?
    @tags ||= parse(tags_path)
  end

  def path
    "layouts/#{@identifier}"
  end

  def frontend_path(name = 'main')
    'contenticus/' + path + "/#{name}"
  end

  def tags_path
    app_path = 'app/views/contenticus/' + path + "/tags.yml"
    if File.exists?(app_path)
      app_path
    else
      Contenticus::Engine.root.join('app', 'views', 'contenticus', 'layouts', @identifier, 'tags.yml')
    end
  end

  def parse(path)
    tags = []
    YAML.load(File.read(File.expand_path(path, Rails.root))).each do |k,v|
      tags << ::Contenticus::Tags::Base.instantiate(@fields,k,v)
    end
    tags
  end

  # List of available application layouts
  def self.available_for(type)
    sub_path = "app/views/contenticus/layouts/"
    Dir.glob(File.expand_path(sub_path + '/' + type + '/*/', Rails.root)).collect do |filename|
      filename.gsub!("#{File.expand_path(sub_path, Rails.root)}/", '')
    end.compact.sort
  end

  def redirect?
    @identifier == 'redirect'
  end

end
