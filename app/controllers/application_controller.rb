class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include Pagy::Backend

  private

  def not_authenticated
    redirect_to new_user_session_path, danger: "ログインしてください"
  end
end
