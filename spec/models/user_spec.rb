require 'rails_helper'

RSpec.describe User, type: :model do

  subject { create(:user) }

  context "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without an email" do
      subject.email = ""
      expect(subject).to_not be_valid
    end

    it "is not valid without matching passwords" do
      subject.password_confirmation = Faker::Internet.password
      expect(subject).to_not be_valid
    end

    describe "attribute validations" do
      it { should validate_presence_of(:email) }
    end

  end

  context "Associations" do
    it { should have_one(:restaurant) }
  end
end