require 'rails_helper'

describe Application, type: :model do
  describe "validations" do
    it { should validate_presence_of :application_status}
  end

  describe "relationships" do
    it { should belong_to :user }
    it { should have_many(:pets).through(:pet_applications) }
  end
end