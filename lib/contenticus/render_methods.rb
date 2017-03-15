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
      @block = page.master_block
      render partial: "contenticus/layouts/#{page.master_block.layout}/main"
    end

  end
end

ActionController::Base.send :include, Contenticus::RenderMethods