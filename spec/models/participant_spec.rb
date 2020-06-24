require 'rails_helper'

RSpec.describe Participant, type: :model do
  let!(:participant) { create(:participant) }

  it "participnatインスタンスが有効であること" do
    expect(participant).to be_valid
  end

  it "user_idがnilの場合、無効であること" do
    participant.user_id = nil
    expect(participant).not_to be_valid
  end

  it "dish_idがnilの場合、無効であること" do
    participant.plan_id = nil
    expect(participant).not_to be_valid
  end
end