class UserMailer < ApplicationMailer
  def send_change_email(user)
    @user = user
    @url = edit_user_registration_url(@user, reset_password_token: @token)
    mail(to: @user.email, subject: "[SweetsLog]個人情報変更用URLのご案内")
  end
end
