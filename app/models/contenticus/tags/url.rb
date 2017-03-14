module Contenticus
module Tags
class Url < Base

  def slug_id
  end

  def href
  end

  def update_attributes(params)
    @values = params.permit(:slug_id, :href)
  end

end
end
end