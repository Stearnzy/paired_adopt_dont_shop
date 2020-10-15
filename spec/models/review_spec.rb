require 'rails_helper'

describe Review, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :rating }
    it { should validate_presence_of :content }
    # I think this is correct?
    # it { should allow_value(nil).for(:picture) }
    # it { should validate_presence_of :picture }
  end

  describe "relationship" do
    it { should belong_to :shelter }
    # it { should belong_to :user }
  end
end