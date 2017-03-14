module Contenticus
module Tags
class TextArea < Base

  def admin_options
    opts = {}
    opts[:label] = name
    opts[:help]  = comment unless comment.blank?
    opts
  end

end
end
end