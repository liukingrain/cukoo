class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook
    @user = Services::OauthUserService.new(request.env["omniauth.auth"]).user
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      @user.save
      sign_in @user
      redirect_to new_user_registration_path
    end
  end
  
end