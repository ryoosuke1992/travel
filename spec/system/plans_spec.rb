require 'rails_helper'

RSpec.describe "Plans", type: :system do
  let!(:user) { create(:user) }
  let!(:plan) { create(:plan) }
	
  describe "旅行投稿ページ" do
		before do
			login_for_system(user)
			visit new_plan_path
		end

		context "ページレイアウト" do
			it "旅行登録の文字が表示される" do
				expect(page).to have_content "旅行登録"
			end

			it "正しいタイトルが表示される" do
				expect(page).to have_title full_title("旅行の登録")
			end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content 'タイトル'
        expect(page).to have_content '開催日'
				expect(page).to have_content '旅行先'
        expect(page).to have_content '集合場所'
        expect(page).to have_content '集合時間'
        expect(page).to have_content '旅行内容'
      end
		end
	end

	describe "旅行詳細ページ" do
		context "ページレイアウト" do
			before do
				login_for_system(user)
				visit plan_path(plan)
			end

      it "旅行情報が表示される" do
        expect(page).to have_content plan.title
        expect(page).to have_content plan.date
        expect(page).to have_content plan.meeting_place
        expect(page).to have_content plan.meeting_time
        expect(page).to have_content plan.content
      end
		end
	end

	describe "旅行編集ページ" do
    before do
      login_for_system(user)
      visit edit_plan_path(plan)
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('旅行の編集')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content 'タイトル'
        expect(page).to have_content '開催日'
        expect(page).to have_content '旅行先'
        expect(page).to have_content '集合場所'
        expect(page).to have_content '集合時間'
        expect(page).to have_content '旅行内容'
      end
    end
  end
end
