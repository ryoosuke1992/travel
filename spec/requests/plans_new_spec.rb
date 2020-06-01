require 'rails_helper'

RSpec.describe "旅行の新規登録", type: :request do
  let!(:user) { create(:user) }
  let!(:plan) { create(:plan, user: user) }
	
  context "ログインしているユーザーの場合" do
    it "レスポンスが正常に表示されること" do
      login_for_request(user)
      get new_plan_path
      expect(response).to have_http_status "200"
      expect(response).to render_template('plans/new')
    end
	end
	
	context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get new_plan_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
