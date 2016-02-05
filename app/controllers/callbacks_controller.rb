class CallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])
    #@user.username = @user.id
    sign_in_and_redirect @user
  end

  def after_sign_in_path_for(user)
    if user.sign_in_count <= 1
      user.username = "pastie#{user.id}"
      flash[:success] = "Please make sure your username is changed through this form otherwise your username will be your ID."
      edit_user_registration_path
    else
      flash[:success] = "Welcome to pastie.xyz!"
      root_path
    end
  end

end
