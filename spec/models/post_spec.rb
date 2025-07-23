require "rails_helper"

RSpec.describe Post, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
      post = build(:post)
      expect(post).to be_valid
      expect(post.errors).to be_empty
    end

    it "メニュー名(title)が無い場合にバリデーションが機能してinvalidになるか" do
      post_without_title = build(:post, title: "")
      expect(post_without_title).to be_invalid
      expect(post_without_title.errors[:title]).to eq [ "を入力してください。" ]
    end

    it "本文(body)が無い場合にバリデーションが機能してinvalidになるか" do
      post_without_body = build(:post, body: "")
      expect(post_without_body).to be_invalid
      expect(post_without_body.errors[:body]).to eq [ "を入力してください。" ]
    end

    it "店名(spot)が無い場合にバリデーションが機能してinvalidになるか" do
      post_without_spot = build(:post, spot: "")
      expect(post_without_spot).to be_invalid
      expect(post_without_spot.errors[:spot]).to eq [ "を入力してください。" ]
    end

    it "住所(address)が無い場合にバリデーションが機能してinvalidになるか" do
      post_without_address = build(:post, address: "")
      expect(post_without_address).to be_invalid
      expect(post_without_address.errors[:address]).to eq [ "を入力してください。" ]
    end

    it "メニュー名(title)が30文字より多い文字数の場合にバリデーションが機能してinvalidになるか" do
      post_too_many_characters_title = build(:post, title: "あ" * 31)
      expect(post_too_many_characters_title).to be_invalid
      expect(post_too_many_characters_title.errors[:title]).to eq [ "は30文字以下で入力して下さい。" ]
    end

    it "本文(body)が1000文字より多い文字数の場合にバリデーションが機能してinvalidになるか" do
      post_too_many_characters_body = build(:post, body: "あ" * 1001)
      expect(post_too_many_characters_body).to be_invalid
      expect(post_too_many_characters_body.errors[:body]).to eq [ "は1000文字以下で入力して下さい。" ]
    end
  end
end
