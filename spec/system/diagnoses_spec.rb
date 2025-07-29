require 'rails_helper'

RSpec.describe "Diagnoses", type: :system do
  let(:user) { create(:user) }

  describe "[ログイン前]" do
    describe "ページ遷移確認" do
      context "診断ページにアクセス" do
        it "診断ページへのアクセスに失敗する" do
          visit new_diagnose_path
          expect(page).to have_content "ログインもしくはアカウント登録してください。"
          expect(current_path).to eq new_user_session_path
        end
      end
    end
  end

  describe "[ログイン後]" do
    before { login_as(user) }

    describe "ページ遷移確認" do
      context "診断ページにアクセス" do
        it "診断ページへのアクセスに成功する" do
          visit new_diagnose_path
          sleep 1
          expect(current_path).to eq new_diagnose_path
        end
      end
    end

    describe "診断機能" do
      context "全ての項目を選択している" do
        it "診断結果が表示される" do
          visit new_diagnose_path
          choose "ゆったりリラックスしたい", allow_label_click: true
          choose "洋菓子", allow_label_click: true
          choose "おなかぺこぺこ", allow_label_click: true
          click_button "診断する"
          sleep 1
          expect(page).to have_content "今のあなたにぴったりのスイーツは…"
        end
      end

      context "選択していない項目がある" do
        it "診断結果が表示されない" do
          visit new_diagnose_path
          choose "ゆったりリラックスしたい", allow_label_click: true
          choose "洋菓子", allow_label_click: true
          click_button "診断する"
          sleep 1
          expect(page).to have_content "選択されていない項目があります。"
        end
      end
    end
  end
end
