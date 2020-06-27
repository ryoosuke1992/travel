RSpec.describe "企画編集", type: :request do
  let!(:user) { create(:user) }
  let!(:plan) { create(:plan, user: user) }
  let(:image_path) { File.join(Rails.root, 'spec/fixtures/travel.jpg') }
  let!(:image) { Rack::Test::UploadedFile.new(image_path) }

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること" do
      login_for_request(user)
      get edit_plan_path(plan)
      expect(response).to render_template('plans/edit')
      patch plan_path(plan), params: { plan: { title: "旅行のタイトル", date: "2021年4月1日", meeting_place: "ハワイ", meeting_time: "13:00", content: "ハワイで海を眺めよう！", image: image } }
      redirect_to plan
      follow_redirect!
      expect(response).to render_template('plans/show')
    end
  end
end
