class SearchUsersController < ApplicationController
  before_action :logged_in_user

  def index
    @users = User.search_user(attribute = "name",str = params[:search]).paginate(page: params[:page])
    respond_to do |format|
      format.html { render "users/index" }
      format.js
    end
  end
end
