module Contenticus::RenderMethods

  def self.included(base)

    def render(options = {}, locals = {}, &block)

      return super unless options.is_a?(Hash)

      page = options.delete(:cms_page)

      if page
        render_cms_page(page, options, locals, &block)
      else
        super
      end
    end

    def render_cms_page(page, options = {}, locals = {}, &block)
      render partial: "contenticus/layouts/pages/#{page.layout}/main", locals: {page: page.master_block}
    end
 
  end
end

ActionController::Base.send :include, Contenticus::RenderMethods