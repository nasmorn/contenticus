class Contenticus::LayoutParser

  attr_reader :tags

  def initialize(path)
    @path = path
    @tags = {}
    parse
  end

  def parse
    File.open(File.expand_path(@path, Rails.root), 'r') do |file|
      file.each_line do |line|
        if line =~ /<%=\s*(cms_field|cms_section|cms_rich_text|cms_image)/
          line.scan(/<%=\s*([^%>]+)%>/).collect {|t| parse_tag t.first}
        end
      end
    end
  end

  def parse_tag(tag)
    tag = tag.gsub("<%=", '').gsub('%>','').gsub('(',' ').gsub(')','').strip
    ast = Parser::CurrentRuby.parse(tag)
    tokens = tag.split(/\s+|,\s*/)
    @tags[eval(tokens.second).to_s] = {type: tokens.first}.merge(create_options_hash(ast))
  end

  def create_options_hash(ast)
    if ast.children.count > 4
      eval Unparser.unparse(ast.children.last)
    else
      {}
    end
  end

end
