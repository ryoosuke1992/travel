require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:admin_user) { create(:user, :admin) }
  let!(:plan) { create(:plan, user: user) }

  describe "ユーザー一覧ページ" do
    context "管理者ユーザーの場合" do
      it "ぺージネーション、自分以外のユーザーの削除ボタンが表示されること" do
        create_list(:user, 30)
        login_for_system(admin_user)
        visit users_path
        expect(page).to have_css "div.pagination"
        User.paginate(page: 1).each do |u|
          expect(page).to have_link u.name, href: user_path(u)
          expect(page).to have_content "#{u.name} | 削除" unless u == admin_user
        end
      end
    end

    context "管理者ユーザー以外の場合" do
      it "ぺージネーション、自分のアカウントのみ削除ボタンが表示されること" do
        create_list(:user, 30)
        login_for_system(user)
        visit users_path
        expect(page).to have_css "div.pagination"
        User.paginate(page: 1).each do |u|
          expect(page).to have_link u.name, href: user_path(u)
          if u == user
            expect(page).to have_content "#{u.name} | 削除"
          else
            expect(page).not_to have_content "#{u.name} | 削除"
          end
        end
      end
    end
  end

  describe "ユーザー登録ページ" do
    before do
      visit signup_path
    end

    context "ユーザー登録処理" do
      it "有効なユーザーでユーザー登録を行うとユーザー登録成功のフラッシュが表示されること" do
        fill_in "ユーザー名", with: "Example User"
        fill_in "メールアドレス", with: "user@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード(確認)", with: "password"
        click_button "登録する"
        expect(page).to have_content "Travelerにようこそ！"
      end

      it "無効なユーザーでユーザー登録を行うとユーザー登録失敗のフラッシュが表示されること" do
        fill_in "ユーザー名", with: ""
        fill_in "メールアドレス", with: "user@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード(確認)", with: "pass"
        click_button "登録する"
        expect(page).to have_content "ユーザー名を入力してください"
        expect(page).to have_content "パスワード(確認)とパスワードの入力が一致しません"
      end
    end

    context "ページレイアウト" do
      it "「ユーザー登録」の文字列が存在することを確認" do
        expect(page).to have_content 'ユーザー登録'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('ユーザー登録')
      end
    end
  end

  describe "プロフィール編集ページ" do
    before do
      login_for_system(user)
      visit edit_user_path(user)
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('プロフィール編集')
      end
    end

    it "有効なプロフィール更新を行うと、更新成功のフラッシュが表示されること" do
      fill_in "ユーザー名", with: "Edit Example User"
      fill_in "メールアドレス", with: "edit-user@example.com"
      fill_in "自己紹介", with: "編集：初めまして"
      fill_in "性別", with: "編集：男性"
      click_button "更新する"
      expect(page).to have_content "プロフィールが更新されました"
      expect(user.reload.name).to eq "Edit Example User"
      expect(user.reload.email).to eq "edit-user@example.com"
      expect(user.reload.introduction).to eq "編集：初めまして"
      expect(user.reload.sex).to eq "編集：男性"
    end

    it "無効なプロフィール更新をしようとすると、適切なエラーメッセージが表示されること" do
      fill_in "ユーザー名", with: ""
      fill_in "メールアドレス", with: ""
      click_button "更新する"
      expect(page).to have_content 'ユーザー名を入力してください'
      expect(page).to have_content 'メールアドレスを入力してください'
      expect(page).to have_content 'メールアドレスは不正な値です'
      expect(user.reload.email).not_to eq ""
    end
  end

  describe "プロフィールページ" do
    context "ページレイアウト" do
      before do
        login_for_system(user)
        create_list(:plan, 10, user: user)
        visit user_path(user)
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('プロフィール')
      end

      it "ユーザー情報が表示されることを確認" do
        expect(page).to have_content user.name
        expect(page).to have_content user.introduction
        expect(page).to have_content user.sex
      end
    end

    context "ユーザーのフォロー/アンフォロー処理", js: true do
      it "ユーザーのフォロー/アンフォローができること" do
        login_for_system(user)
        visit user_path(other_user)
        expect(page).to have_button 'フォローする'
        click_button 'フォローする'
        expect(page).to have_button 'フォロー中'
        click_button 'フォロー中'
        expect(page).to have_button 'フォローする'
      end
    end

    context "お気に入り登録/解除" do
      before do
        login_for_system(user)
      end

      it "企画のお気に入り登録/解除ができること" do
        expect(user.favorite?(plan)).to be_falsey
        user.favorite(plan)
        expect(user.favorite?(plan)).to be_truthy
        user.unfavorite(plan)
        expect(user.favorite?(plan)).to be_falsey
      end
    end
  end
end
