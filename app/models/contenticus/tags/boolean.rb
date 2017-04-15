module Contenticus
module Tags
class Boolean < Base

  def initialize(values, key:, name: nil, comment: nil, hidden: false, parent: parent)
    super values, key: key, name: name, comment: comment, parent: parent
    @hidden = hidden
  end

  def render
    raise 'Boolean cannot be rendered'
  end

  def true?
    value == '1' || value == 'true' || value == true
  end

  def serialize
    {
      key => true?
    }
  end

  def hidden?
    @hidden
  end

end
end
end
