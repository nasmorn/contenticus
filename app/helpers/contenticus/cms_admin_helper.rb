module Contenticus::CmsAdminHelper

  def field_for_tag(form, tag)
    render "contenticus/admin/tags/#{tag.type}", form: form, tag: tag
  end

end
