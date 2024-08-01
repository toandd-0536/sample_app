class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_user, only: :create
  before_action :load_relationship, only: :destroy

  def create
    current_user.follow @user
    redirect_to @user
  end

  def destroy
    @user = @relationship.followed
    current_user.unfollow @user
    redirect_to @user
  end

  private
  def load_user
    @user = User.find_by id: params[:followed_id]
    return if @user

    flash[:error] = t "controllers.users.find_message_error"
    redirect_to root_path
  end

  def load_relationship
    @relationship = Relationship.find_by id: params[:id]
  end
end
