# frozen_string_literal: true

module Contenticus
  # Returns a sitemap for all pages
  class SitemapController < ApplicationController
    def index
      urls = Contenticus::Page.includes(:slug)
                              .joins(:slug)
                              .map do |page|
                                request.protocol + request.host + page.slug.full_path
                              end

      render plain: urls.join("\n")
    end
  end
end
