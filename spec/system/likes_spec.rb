require 'rails_helper'

RSpec.describe "Likes", type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  describe "[ログイン前]" do
    describe "ページ遷移確認" do
      context "お気に入り投稿一覧ページにアクセス" do
        it "お気に入り投稿一覧ページへのアクセスに失敗する" do
          visit likes_posts_path
          expect(page).to have_content "ログインもしくはアカウント登録してください。"
          expect(current_path).to eq new_user_session_path
        end
      end
    end
  end

  describe "[ログイン後]" do
    before { login_as(user) }

    describe "ページ遷移確認" do
      context "お気に入り投稿一覧ページにアクセス" do
        it "お気に入り投稿一覧ページへのアクセスに成功する" do
          visit likes_posts_path
          expect(current_path).to eq likes_posts_path
        end
      end
    end

    describe "いいね機能" do
      let!(:post) { create(:post) }

      it "ハートボタンを押すといいね数が1増える" do
        like_button = find("#like-button-for-post-#{post.id}")
        expect { like_button.click sleep 1 }.to change { post.reload.likes.count }.by(1)
        expect(page).to have_selector("#unlike-button-for-post-#{post.id}", text: "1")
      end

      it "再度ハートボタンを押すといいね数が1減る" do
        like_button = find("#like-button-for-post-#{post.id}")
        expect { like_button.click sleep 1 }.to change { post.reload.likes.count }.by(1)
        expect(page).to have_selector("#unlike-button-for-post-#{post.id}", text: "1")
        unlike_button = find("#unlike-button-for-post-#{post.id}")
        expect { unlike_button.click sleep 1 }.to change { post.reload.likes.count }.by(-1)
        expect(page).to have_selector("#like-button-for-post-#{post.id}", text: "0")
      end
    end
  end
end
