class Contenticus::PagesController < ApplicationController
  layout nil

  def index
    page = Contenticus::Page.new
    page.layout = "base"
    page.master_block = Contenticus::Block.new
    page.master_block.fields = {"title" => "WOW"}
    page.master_block.blocks.build(section: "list", layout: "list", fields: {content: "dick"})
    page.master_block.blocks.build(section: "list", layout: "list", fields: {content: "suckit"})

    render cms_page: page
  end

end