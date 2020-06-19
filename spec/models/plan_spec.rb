require 'rails_helper'

RSpec.describe Plan, type: :model do
  let!(:plan) { create(:plan) }
  
  context "バリデーション" do
    it "有効な状態であること" do
      expect(plan).to be_valid
    end
  end
end
