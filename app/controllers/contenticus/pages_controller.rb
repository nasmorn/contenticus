# frozen_string_literal: true

module Contenticus
  class PagesController < ApplicationController
    def show
      @page = find_page
      @block = @page.block
      @meta = Contenticus::Meta.from_page(@page)

      if @page.redirect?
        redirect_to @page.redirect_target
      else
        render @block.frontend_layout
      end
    end

    private

    def find_page
      Contenticus::Slug.find_by!(full_path: "/#{params[:cms_path]}").sluggable
    end
  end
end
