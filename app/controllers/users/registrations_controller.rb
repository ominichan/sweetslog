# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [ :create ]
  before_action :configure_account_update_params, only: [ :update ]
  before_action :check_edit_token, only: [ :edit ]
  after_action :clear_edit_token, only: [ :update ]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  def edit
    @user = current_user
  end

  # PUT /resource

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [ :email ])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    root_path
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    root_path
  end

  def update_resource(resource, params)
    resource.update_with_password(params)
  end

  def after_update_path_for(resource)
    profile_user_path(current_user.id)
  end

  def check_edit_token
    token = params[:token]
    if token.present? &&
      current_user&.edit_profile_token == token &&
      current_user&.edit_profile_token_expires_at.present? &&
      current_user.edit_profile_token_expires_at > Time.current
     
      return
    end
    if current_user&.edit_profile_token_expires_at.present? && current_user.edit_profile_token_expires_at < Time.current
      redirect_to root_path, alert: "このURLは無効または期限切れです。"
    else
      redirect_to root_path, alert: "不正なアクセスです。"
    end
  end

  def clear_edit_token
    current_user.update(edit_profile_token: nil, edit_profile_token_expires_at: nil)
  end
end
