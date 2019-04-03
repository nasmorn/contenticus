require 'rails_helper'

RSpec.describe Contenticus::Tags::Block, type: :model do

  let(:options) {
    {
      type: 'block',
      layout: 'block_test',
    }
  }

  it "can instantiate a text_field with string options" do
    tag = Contenticus::Tags::Base.instantiate({}, 'dablock', options)
    expect(tag.class.name).to eq('Contenticus::Tags::Block')
    expect(tag.key).to eq('dablock')
    expect(tag.layout).to receive(:tags_path).and_return(mock_layout('block_test/tags.yml'))
    expect(tag.tags.map(&:type)).to eq(['url', 'text_field', 'image_field'])
    expect(tag.tags.map(&:key)).to  eq(['url', 'titel', 'bild'])
  end

  context 'update contenticus-published field' do
    let(:tag) { Contenticus::Tags::Base.instantiate({},'dablock', options) }
    let(:params) do
      {
        "contenticus-published"=>{"value"=>"1"},
        "url"   => {},
        "titel" => {},
        "bild"  => {}
      }
    end

    before do
      expect(tag.layout).to receive(:tags_path).and_return(mock_layout('block_test/tags.yml'))
    end

    it "can update the blocks contenticus-published field" do
      tag.update_attributes(params)
      expect(tag.published?).to eq(true)
    end

    it "serializes contenticus-published field" do
      tag.update_attributes(params)
      expect(tag.serialize.fetch("dablock").fetch("contenticus-published")).to eq(true)
    end

  end


end
