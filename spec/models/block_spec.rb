require 'rails_helper'

RSpec.describe Contenticus::Block, type: :model do

  subject {described_class}

  it 'can serialize the fields' do
    page = Fabricate.create(:page)
    expect{described_class.create!(blockable: page, layout: "pages/frontpage")}.to change(subject, :count).by(1)
  end

end
