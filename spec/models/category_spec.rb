require 'rails_helper'

RSpec.describe Category, type: :model do

  subject { create(:category) }

  context "Validations" do
    it "should be valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "should not be valid without a title" do
      subject.title = ""
      expect(subject).to_not be_valid
    end

    it "should not be valid without a restaurant reference" do
      subject.restaurant_id = nil
      expect(subject).to_not be_valid
    end
  end

  context "Associations" do
    it { should belong_to(:restaurant) }
    it { should have_many(:products) }
  end
end