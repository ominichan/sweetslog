require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  describe "[ログイン前]" do
    describe 'ユーザー新規登録' do
      context "フォームの入力値が正常" do
        it "ユーザー登録処理が成功する" do
          visit new_user_registration_path
          fill_in "ユーザーネーム", with: "SweetsLogTEST"
          fill_in "メールアドレス", with: "sweetslog_test_123@example.com"
          fill_in "パスワード（6文字以上）", with: "password123"
          fill_in "もう一度入力してください", with: "password123"
          click_button "登録"
          expect(page).to have_content "ユーザーを登録しログインしました。"
          expect(current_path).to eq posts_path
        end
      end

      context "メールアドレスが未入力" do
        it "ユーザー登録処理が失敗する" do
          visit new_user_registration_path
          fill_in "ユーザーネーム", with: ""
          fill_in "メールアドレス", with: "sweetslog_test_123@example.com"
          fill_in "パスワード（6文字以上）", with: "password123"
          fill_in "もう一度入力してください", with: "password123"
          click_button "登録"
          expect(page).to have_content "ユーザーネームを入力してください。"
          expect(current_path).to eq new_user_registration_path
        end
      end

      context "登録済みのメールアドレスを入力する" do
        it "ユーザー登録処理が失敗する" do
          existed_user = create(:user)
          visit new_user_registration_path
          fill_in "ユーザーネーム", with: "SweetsLogTEST2"
          fill_in "メールアドレス", with: existed_user.email
          fill_in "パスワード（6文字以上）", with: "password123"
          fill_in "もう一度入力してください", with: "password123"
          click_button "登録"
          expect(page).to have_content "メールアドレスは既に使用されています。"
          expect(current_path).to eq new_user_registration_path
        end
      end
    end

    describe "マイページ" do
      context "ログインしていない状態" do
        it "マイページへのアクセスが失敗する" do
          visit user_path(user)
          expect(page).to have_content("ログインもしくはアカウント登録してください。")
          expect(current_path).to eq new_user_session_path
        end
      end
    end
  end

  describe "[ログイン後]" do
    before { login_as(user) }

    describe "プロフィール編集" do
      context "名前を変更する" do
        it "名前の変更が成功する" do
          visit edit_user_path(user)
          fill_in "ユーザーネーム", with: "SweetsLogTEST2"
          click_button "更新する"
          expect(page).to have_content("プロフィールを更新しました。")
          expect(current_path).to eq profile_user_path(user)
        end
      end

      context "他ユーザーの編集ページにアクセス" do
        let!(:other_user) { create(:user, email: "sweetslog_test_other@example.com") }

        it "編集ページへのアクセスが失敗する" do
          visit edit_user_path(other_user)
          expect(page).to have_content "不正なアクセスです。"
          expect(current_path).to eq user_path(user)
        end
      end
    end
  end
end
