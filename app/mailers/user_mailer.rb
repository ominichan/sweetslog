class UserMailer < ApplicationMailer
  def send_change_email(user)
    @user = user
    @token = SecureRandom.urlsafe_base64(32)
    @user.update!(edit_profile_token: @token, edit_profile_token_expires_at: 30.minutes.from_now)
    @url = edit_user_registration_url(token: @token)
    mail(to: @user.email, subject: "[SweetsLog]個人情報変更用URLのご案内")
  end
end
