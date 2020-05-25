module Contenticus
module Tags
class Link < Base

  attr_reader :accept_name

  def initialize(values, key:, name: nil, comment: nil, parent: nil, accept_name: true, url_options: {})
    super values, key: key, name: name, comment: comment, parent: parent
    @values ||= {}
    @url_options = url_options
    @accept_name = accept_name
  end

  def slug_id
    @values[:slug_id] if @values
  end

  def href
    @values[:href] if @values
  end

  def name
    @values[:name] if @values
  end

  def blank
    @values[:blank] if @values
  end

  def target
    if blank == '1'
      '_blank'
    else
      '_self'
    end
  end

  def update_attributes(params)
    @values = params.slice(:slug_id, :href, :blank, :name)
  end

  def url
    if slug_id.present?
      Contenticus::Slug.find(slug_id).full_path
    else
      href
    end
  end

  def url_options
    @url_options.merge(target: target)
  end

end
end
end
