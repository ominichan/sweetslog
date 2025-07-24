require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  describe "[ログイン前]" do
    describe "ページ遷移確認" do
      context "投稿一覧ページにアクセス" do
        it "投稿一覧ページへのアクセスが成功し、全てのユーザーのタスク情報が表示される" do
          post_list = create_list(:post, 3)
          visit posts_path
          expect(page).to have_content post_list[0].title
          expect(page).to have_content post_list[1].title
          expect(page).to have_content post_list[2].title
          expect(page).not_to have_css('.alert')
          expect(current_path).to eq posts_path
        end
      end

      context "投稿詳細ページにアクセス" do
        it "投稿詳細ページへのアクセスが成功し、投稿詳細が表示される" do
          visit post_path(post)
          expect(page).to have_content post.title
          expect(current_path).to eq post_path(post)
        end
      end

      context "新規投稿作成ページにアクセス" do
        it "新規投稿作成ページへのアクセスに失敗する" do
          visit new_post_path
          expect(page).to have_content "ログインもしくはアカウント登録してください。"
          expect(current_path).to eq new_user_session_path
        end
      end

      context "投稿編集ページにアクセス" do
        it "投稿編集ページへのアクセスが失敗する" do
          visit edit_post_path(post)
          expect(page).to have_content "ログインもしくはアカウント登録してください。"
          expect(current_path).to eq new_user_session_path
        end
      end
    end
  end

  describe "[ログイン後]" do
    before { login_as(user) }

    describe "新規投稿作成" do
      context "フォームの入力値が正常" do
        it "投稿作成が成功する" do
          visit new_post_path
          fill_in id: "title", with: "test_title_1"
          fill_in id: "body", with: "テスト投稿です。"
          fill_in id: "spot", with: "大阪城"
          fill_in id: "address", with: "日本、〒540-0002 大阪府大阪市中央区大阪城１−１"
          click_button "投稿"
          expect(page).to have_content "test_title_1"
          expect(page).to have_content "ポストが作成されました"
          expect(current_path).to eq posts_path
        end
      end

      context "メニュー名(title)が未入力" do
        it "投稿作成が失敗する" do
          visit new_post_path
          fill_in id: "title", with: ""
          fill_in id: "body", with: "テスト投稿です。"
          fill_in id: "spot", with: "大阪城"
          fill_in id: "address", with: "日本、〒540-0002 大阪府大阪市中央区大阪城１−１"
          click_button "投稿"
          expect(page).to have_content "メニュー名を入力してください。"
          expect(current_path).to eq new_post_path
        end
      end

      context "本文(body)が未入力" do
        it "投稿作成が失敗する" do
          visit new_post_path
          fill_in id: "title", with: "test_title_1"
          fill_in id: "body", with: ""
          fill_in id: "spot", with: "大阪城"
          fill_in id: "address", with: "日本、〒540-0002 大阪府大阪市中央区大阪城１−１"
          click_button "投稿"
          expect(page).to have_content "本文を入力してください。"
          expect(current_path).to eq new_post_path
        end
      end

      context "店名(spot)が未入力" do
        it "投稿作成が失敗する" do
          visit new_post_path
          fill_in id: "title", with: "test_title_1"
          fill_in id: "body", with: "テスト投稿です。"
          fill_in id: "spot", with: ""
          fill_in id: "address", with: "日本、〒540-0002 大阪府大阪市中央区大阪城１−１"
          click_button "投稿"
          expect(page).to have_content "店名を入力してください。"
          expect(current_path).to eq new_post_path
        end
      end

      context "住所(address)が未入力" do
        it "投稿作成が失敗する" do
          visit new_post_path
          fill_in id: "title", with: "test_title_1"
          fill_in id: "body", with: "テスト投稿です。"
          fill_in id: "spot", with: "大阪城"
          fill_in id: "address", with: ""
          click_button "投稿"
          expect(page).to have_content "住所を入力してください。"
          expect(current_path).to eq new_post_path
        end
      end
    end

    describe "投稿編集" do
      let!(:post) { create(:post, user: user) }
      let(:other_post) { create(:post, user: user) }
      before { visit edit_post_path(post) }

      context "フォームの入力値が正常" do
        it "投稿編集が成功する" do
          fill_in id: "title", with: "test_update_title_1"
          fill_in id: "body", with: "テスト編集投稿です。"
          fill_in id: "spot", with: "大阪城"
          fill_in id: "address", with: "日本、〒540-0002 大阪府大阪市中央区大阪城１−１"
          click_button "投稿"
          expect(page).to have_content "ポストが更新されました"
          expect(current_path).to eq post_path(post)
        end
      end

      context "メニュー名(title)が未入力" do
        it "投稿編集が失敗する" do
          fill_in id: "title", with: nil
          fill_in id: "body", with: "テスト投稿です。"
          fill_in id: "spot", with: "大阪城"
          fill_in id: "address", with: "日本、〒540-0002 大阪府大阪市中央区大阪城１−１"
          click_button "投稿"
          expect(page).to have_content "メニュー名を入力してください。"
          expect(current_path).to eq edit_post_path(post)
        end
      end

      context "他ユーザーのタスク編集ページにアクセス" do
        let!(:other_user) { create(:user, email: "sweetslog_test_other@example.com") }
        let!(:other_post) { create(:post, user: other_user) }

        it "投稿編集ページへのアクセスが失敗する" do
          visit edit_post_path(other_post)
          expect(page).to have_content "不正なアクセスです。"
          expect(current_path).to eq posts_path
        end
      end
    end
    
    describe "投稿削除" do
      let!(:post) { create(:post, user: user) }

      it "投稿の削除が成功する" do
        visit post_path(post)
        click_link id: "post_destroy"
        expect(page.accept_confirm).to eq "本当に削除しますか？"
        expect(page).to have_content "ポストが削除されました"
        expect(current_path).to eq posts_path
        expect(page).not_to have_content post.title
      end
    end
  end
end
