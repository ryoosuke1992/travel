require 'rails_helper'

RSpec.describe "旅行の新規登録", type: :request do
  let!(:user) { create(:user) }
  let!(:plan) { create(:plan, user: user) }
  let(:image_path) { File.join(Rails.root, 'spec/fixtures/travel.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }

  context "ログインしているユーザーの場合" do
    before do
      login_for_request(user)
      get new_plan_path
    end

    it "レスポンスが正常に表示されること" do
      expect(response).to have_http_status "200"
      expect(response).to render_template('plans/new')
    end

    it "有効な旅行企画が登録できること" do
      expect { post plans_path, params: { plan: { title: "みんなで行こうオーストラリアのグレートバリアリーフ", date: "2021年4月1日", place: "オーストラリア", meeting_place: "オーストラリア空港", meeting_time: "13:00", content: "オーストラリアに行きましょう！", plan_comment: "オーストラリアに行きましょう！", image: image } } }.to change(Plan, :count).by(1)
      follow_redirect!
      expect(response).to render_template('plans/show')
    end

    it "無効な旅行企画は登録できない" do
      expect { post plans_path, params: { plan: { title: "", date: "2021年4月1日", place: "オーストラリア", meeting_place: "オーストラリア空港", meeting_time: "13:00", content: "オーストラリアに行きましょう！" } } }.not_to change(Plan, :count)
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
