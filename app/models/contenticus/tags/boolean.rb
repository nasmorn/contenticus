module Contenticus
module Tags
class Boolean < Base

  def render
    raise 'Boolean cannot be rendered'
  end

  def true?
    value == '1'
  end

end
end
end