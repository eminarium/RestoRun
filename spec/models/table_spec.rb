require "rails_helper"

RSpec.describe Table, type: :model do

  subject { create(:table) }

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

    describe "attribute validations" do
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:restaurant_id) }
    end
  end

  context "Associations" do
    it { should belong_to(:restaurant) }
  end
end