require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  subject { create(:restaurant) }

  context "Validations" do

    it "should be valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "should not be valid without a title" do
      subject.title = ""
      expect(subject).to_not be_valid
    end

    it "should be valid without boolean attributes provided (is_halal, is_kosher, is_vegetarian)" do
      subject.is_halal = nil
      subject.is_kosher = nil
      subject.is_vegetarian = nil
      
      expect(subject).to be_valid
    end

    describe "attribute validations" do
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:user_id) }
    end
  end

  context "Associations" do
    it { should belong_to(:user) }
    it { should have_many(:categories) }
    it { should have_many(:products) }
    it { should have_many(:tables) }
  end
end