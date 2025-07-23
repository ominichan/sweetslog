require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it "ユーザーネーム(name)が無い場合にバリデーションが機能してinvalidになるか" do
      user_without_name = build(:user, name: "")
      expect(user_without_name).to be_invalid
      expect(user_without_name.errors[:name]).to eq ["を入力してください。"]
    end

    it "メールアドレス(email)が無い場合にバリデーションが機能してinvalidになるか" do
      user_without_email = build(:user, email: "")
      expect(user_without_email).to be_invalid
      expect(user_without_email.errors[:email]).to eq ["を入力してください。", "は有効でありません。"]
    end

    it "パスワード(password)が無い場合にバリデーションが機能してinvalidになるか" do
      user_without_password = build(:user, password: "")
      expect(user_without_password).to be_invalid
      expect(user_without_password.errors[:password]).to eq ["を入力してください。"]
    end

    it "確認用パスワード(password_confirmation)が無い場合にバリデーションが機能してinvalidになるか" do
      user_without_password_confirmation = build(:user, password_confirmation: "")
      expect(user_without_password_confirmation).to be_invalid
      expect(user_without_password_confirmation.errors[:password_confirmation]).to eq ["とパスワードの入力が一致しません。"]
    end

    it "メールアドレス(email)が不正な値(@が無い、値の間に@が無い)の場合にバリデーションが機能してinvalidになるか" do
      user_fraud_email = build(:user, email: "abcdefg")
      expect(user_fraud_email).to be_invalid
      expect(user_fraud_email.errors[:email]).to eq ["は有効でありません。"]
    end
  end
end
