require 'rails_helper'

RSpec.describe Contenticus::Page, type: :model do
  
  it "creates the intial page without a slug given" do
    page = Contenticus::Page.new(slug_attributes: {label: "Startseite"}, master_block_attributes: {layout: "base", locale: "en"} )
    expect(page.save).to be_truthy
  end

end
