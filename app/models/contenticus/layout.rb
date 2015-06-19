class Contenticus::Layout

  def initialize(identifier, type)
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
    Contenticus::Layout.parse 'app/views/contenticus/' + path + "/_main.html.erb"
  end

  def self.parse(path)
    tags = {}
    File.open(File.expand_path(path, Rails.root), 'r') do |file|
      file.each_line do |line|
        if line =~ /<%=\s*(cms_field|cms_section)/
          line.scan(/<%=\s*([^%>]+)%>/).collect {|t| parse_tag t.first, tags}
        end
      end
    end
    return tags
  end

  def self.parse_tag(tag, tags)
    tag = tag.gsub("<%=", '').gsub('%>','').gsub('(',' ').gsub(')','').strip
    tokens = tag.split(/\s+|,\s*/)
    tags[eval(tokens.second).to_s] = {type: tokens.first}
  end

  def self.tag_type(method_name)
    if method_name == "cms_field"
      "string"
    elsif method_name == "cms_section"
      "section"
    end
  end

end