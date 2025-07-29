require 'rails_helper'

RSpec.describe "Comments", type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  describe "[ログイン後]" do
    before { login_as(user) }

    describe "新規コメント投稿" do
      context "フォームの入力値が正常" do
        it "コメント投稿が成功する" do
          visit post_path(post)
          fill_in id: "comment", with: "テストコメントです。"
          click_button "投稿"
          expect(page).to have_content "テストコメントです。"
          expect(current_path).to eq post_path(post)
        end
      end
    end
  end
end
