require 'rails_helper'

RSpec.describe Contenticus::LayoutParser, type: :model do

  it "parses the options from an image tag" do
    image = Contenticus::LayoutParser.new(mock_layout("image_tag_options.html.erb")).tags["bild"]

    # Type
    expect(image[:type]).to eq("cms_image")
    puts image
    # Aspect
    expect(image[:aspect]).to eq("2:1")
  end

end
