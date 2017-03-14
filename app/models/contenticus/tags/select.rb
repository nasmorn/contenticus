module Contenticus
module Tags
class Select < Base

  attr_reader :scope

  def initialize(block, key:, name: nil, comment: nil, model:)
    super block, key: key, name: name, comment: comment
    @model = model.classify.constantize
    @scope = @model.all
  end

  def options
    @scope.pluck(:label, :id)
  end

end
end
end