require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
      comment = build(:comment)
      expect(comment).to be_valid
      expect(comment.errors).to be_empty
    end

    it "本文(body)が無い場合にバリデーションが機能してinvalidになるか" do
      comment_without_body = build(:comment, body: "")
      expect(comment_without_body).to be_invalid
      expect(comment_without_body.errors[:body]).to eq [ "を入力してください。" ]
    end
  end
end
