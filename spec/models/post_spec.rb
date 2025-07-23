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
      expect(post_without_title.errors.full_messages_for(:title)).to eq ["メニュー名を入力してください"]
    end

    it "本文(body)が無い場合にバリデーションが機能してinvalidになるか" do
      post_without_body = build(:post, body: "")
      expect(post_without_body).to be_invalid
      expect(post_without_body.errors.full_messages_for(:body)).to eq ["本文を入力してください"]
    end

    it "店名(spot)が無い場合にバリデーションが機能してinvalidになるか" do
      post_without_spot = build(:post, spot: "")
      expect(post_without_spot).to be_invalid
      expect(post_without_spot.errors.full_messages_for(:spot)).to eq ["店名を入力してください"]
    end

    it "住所(address)が無い場合にバリデーションが機能してinvalidになるか" do
      post_without_address = build(:post, address: "")
      expect(post_without_address).to be_invalid
      expect(post_without_address.errors.full_messages_for(:address)).to eq ["住所を入力してください"]
    end
  end
end
