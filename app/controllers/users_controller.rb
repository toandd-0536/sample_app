class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(edit update show destroy)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(show edit update)
  before_action :admin_user, only: :destroy

  def index
    @pagy, @users = pagy(User.ordered,
                         limit: Settings.controllers.users.per_page)
  end

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:success] = t "controllers.users.created_message"
      redirect_to root_url, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "controllers.users.updated_message"
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "controllers.users.destroyed_message"
    else
      flash[:danger] = t "controllers.users.destroyed_message_error"
    end
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user)
          .permit(:name, :password, :email, :password_confirmation)
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:error] = t "controllers.users.find_message_error"
    redirect_to root_path
  end

  def correct_user
    return if current_user?(@user)

    flash[:error] = t "controllers.users.correct_user_error"
    redirect_to root_path
  end

  def admin_user
    return if current_user.admin?

    flash[:error] = t "controllers.users.admin_error"
    redirect_to root_path
  end
end
