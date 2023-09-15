require 'rails_helper'

RSpec.describe Product, type: :model do

  subject { create(:product) }

  context "Validations" do
    it "should be valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "should not be valid with a negative price value" do
      subject.price = -1
      expect(subject).to_not be_valid
    end

    it "should not be valid without a category reference" do
      subject.category_id = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid without a restaurant reference" do
      subject.restaurant_id = nil
      expect(subject).to_not be_valid
    end

    describe "attribute validations" do
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:category_id) }
      it { should validate_presence_of(:restaurant_id) }
      it { should validate_presence_of(:price) }
      it { should validate_numericality_of(:price) }
    end
  end

  context "Associations" do
    it { should belong_to(:category) }
    it { should belong_to(:restaurant) }
  end
end