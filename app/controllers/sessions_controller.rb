class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params.dig(:session, :email)&.downcase
    if user&.authenticate params.dig(:session, :password)
      log_in user
      flash[:success] = t("controllers.sessions.login_message")
      redirect_to user
    else
      flash.now[:danger] = t("controllers.sessions.danger")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    flash[:success] = t("controllers.sessions.logout_message")
    redirect_to root_path
  end
end
