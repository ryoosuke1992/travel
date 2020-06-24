require 'rails_helper'

RSpec.describe "旅行参加機能", type: :request do
  let(:user) { create(:user) }
  let(:plan) { create(:plan) }

  context "旅行参加処理" do
    context "ログインしていない場合" do
      it "旅行の参加は実行できず、ログインページへリダイレクトすること" do
        expect {
          post "/participants/#{plan.id}/create"
        }.not_to change(Participant, :count)
        expect(response).to redirect_to login_path
      end
    end
  end
end