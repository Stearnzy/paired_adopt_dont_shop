require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should belong_to :users}
    it { should belong_to :pets}
  end
end