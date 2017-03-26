module Contenticus
module Tags
class TextArea < Base

  def admin_options
    opts = {}
    opts[:label] = name
    opts[:help]  = comment unless comment.blank?
    opts['data-cms-cm-mode'] = 'text/x-markdown'
    opts
  end

  def render
    if value
      Kramdown::Document.new(value).to_html.html_safe
    end
  end

end
end
end