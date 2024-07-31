class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params.dig(:session, :email)&.downcase
    if user.try :authenticate, params.dig(:session, :password)
      if user.activated?
        forwarding_url = session[:forwarding_url]
        reset_session
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        log_in user
        redirect_to forwarding_url || user
      else
        flash[:warning] = t "controllers.sessions.warning"
        redirect_to root_url, status: :see_other
      end
    else
      flash.now[:danger] = t "controllers.sessions.danger"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    flash[:success] = t("controllers.sessions.logout_message")
    redirect_to root_path
  end
end
