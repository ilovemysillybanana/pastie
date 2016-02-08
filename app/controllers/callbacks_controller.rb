class CallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])
    username_setter(@user)
    sign_in_and_redirect @user
  end

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    username_setter(@user)
    sign_in_and_redirect @user
  end

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])
    username_setter(@user)
    sign_in_and_redirect @user
  end

  def after_sign_in_path_for(user)
    if user.sign_in_count == 0 || user.sign_in_count == 1
      #user.username = "pastie#{user.id}"
      flash[:success] = "Please make sure your username is changed through this form otherwise your username will be your ID."
      edit_user_registration_path
    else
      flash[:success] = "Welcome to pastie.xyz!"
      root_path
    end
  end

  private
  def username_setter(user)
    user.username = "pastie_user_#{user.id}"
  end

end
