module Contenticus
module Tags
class TextField < Base

  def render
    Kramdown::Document.new(value).to_html.gsub('<p>','').gsub('</p>','').html_safe
  end

end
end
end