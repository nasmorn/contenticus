require 'rails_helper'

RSpec.describe Contenticus::Tags::Base, type: :model do

  it "can instantiate a text_field with string options" do
    tag = Contenticus::Tags::Base.instantiate({},'title', 'text_field')
    expect(tag.class.name).to eq('Contenticus::Tags::TextField')
    expect(tag.key).to eq('title')
  end

  it "can instantiate a text_field with hash options" do
    tag = Contenticus::Tags::Base.instantiate({},'title', {'type' => 'text_field'})
    expect(tag.class.name).to eq('Contenticus::Tags::TextField')
    expect(tag.key).to eq('title')
  end

end
