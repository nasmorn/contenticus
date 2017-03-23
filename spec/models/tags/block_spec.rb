require 'rails_helper'

RSpec.describe Contenticus::Tags::Block, type: :model do

  let(:options) {
    {
      type: 'block',
      layout: 'block_test',
    }
  }

  it "can instantiate a text_field with string options" do
    tag = Contenticus::Tags::Base.instantiate({},'dablock', options)
    expect(tag.class.name).to eq('Contenticus::Tags::Block')
    expect(tag.key).to eq('dablock')
    expect(tag.layout).to receive(:tags_path).and_return(mock_layout('block_test/tags.yml'))
    expect(tag.tags.map(&:type)).to eq(['url', 'text_field', 'image_field'])
    expect(tag.tags.map(&:key)).to  eq(['url', 'titel', 'bild'])
  end

end
