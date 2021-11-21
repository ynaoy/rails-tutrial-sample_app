class RsssController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user

  def index
    @user = User.find(params[:id])
    @feeds = @user.feed.limit(10)

    respond_to do |format|
      format.html
      format.rss { render layout: false }
    end
  end

  private
    def correct_user
      redirect_to root_url unless current_user.id == params[:id].to_i
    end
end
