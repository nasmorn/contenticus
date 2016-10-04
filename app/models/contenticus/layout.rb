class Contenticus::Layout

  def initialize(identifier, type)
    raise "No Identifier given" if identifier.blank?
    @identifier = identifier
    @type = type
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
    Contenticus::LayoutParser.new('app/views/contenticus/' + path + "/_main.html.erb").tags
  end


end