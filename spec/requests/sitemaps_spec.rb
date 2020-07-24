# frozen_string_literal: true

require "rails_helper"

RSpec.describe Contenticus::SitemapController, type: :request do
  describe "index" do
    let!(:root_slug) { Fabricate.create(:slug, slug: "/") }
    let!(:root_page) { Fabricate.create(:page, slug: root_slug) }
    let!(:slug) { Fabricate.create(:slug, slug: "page", parent: root_slug) }
    let!(:rpage) { Fabricate.create(:page, slug: slug) }

    before do
      get "/sitemap"
    end

    it "should return 200" do
      expect(response).to have_http_status(200)
    end

    it "returns the urls" do
      expect(response.body.lines).to eq(["http://www.example.com/\n", "http://www.example.com/page"])
    end
  end
end
