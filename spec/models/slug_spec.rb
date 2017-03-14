require 'rails_helper'

RSpec.describe Contenticus::Slug, type: :model do

  subject {described_class}

  it "creates a slug" do
    expect{subject.create(label: 'Startseite')}.to change(subject, :count).by(1)
  end

  context 'with root slug' do
    let!(:root_slug) { described_class.create(label: 'Startseite') }

    it 'creates a first child slug' do
      expect{subject.create!(slug: 'child', label: 'Child', parent: root_slug)}.to change(subject, :count).by(1)
    end
  end

end
