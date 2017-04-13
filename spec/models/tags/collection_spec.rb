require 'rails_helper'

RSpec.describe Contenticus::Tags::Collection, type: :model do

  let(:options) {
    {
      type: 'collection',
      min: 2,
      tag: { type: 'text_field'}
    }
  }

  let(:params) {
    {
      "contenticus-published"=>{"value"=>"0"},
      "1"=>{"value"=>"boom"},
      "2"=>{"value"=>"zack"},
    }
  }

  it "can instantiate a collection" do
    tag = Contenticus::Tags::Base.instantiate({},'dacollection', options)
    expect(tag.class.name).to eq('Contenticus::Tags::Collection')
    expect(tag.key).to eq('dacollection')

    expect(tag.tags.map(&:type)).to eq(['text_field', 'text_field'])
  end

  it "will have a published tag that defaults to true" do
    tag = Contenticus::Tags::Base.instantiate({},'dacollection', options)
    expect(tag.published_tag.class.name).to eq('Contenticus::Tags::Boolean')
    expect(tag.published?).to eq(true)
  end

  it "will update the values correctly, including published state" do
    tag = Contenticus::Tags::Base.instantiate({},'dacollection', options)
    expect(tag.published?).to eq(true)
    tag.update_attributes(params)
    expect(tag.published?).to eq(false)
  end

  it "will serialize the published tag" do
    tag = Contenticus::Tags::Base.instantiate({},'dacollection', options)
    tag.update_attributes(params)
    expect(tag.serialize).to eq({"dacollection" => {"contenticus-published" => false, "1"=>{"value"=>"boom"}, "2"=>{"value"=>"zack"}}})
  end

end
