module Contenticus
module Tags
class Url < Base

  def slug_id
    @values[:slug_id] if @values
  end

  def href
    @values[:href] if @values
  end

  def update_attributes(params)
    @values = params.slice(:slug_id, :href)
  end

  def url
    if slug_id.present?
      Contenticus::Slug.find(slug_id).full_path
    else
      href
    end
  end

  def render
    url
  end

end
end
end
