class NoticeFollowersController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find(params[:id])
    @user.notice_follow
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.not_notice_follow
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
