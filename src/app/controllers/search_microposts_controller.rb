class SearchMicropostsController < ApplicationController
  before_action :logged_in_user
  def index
    @micropost  = current_user.microposts.build
    @feed_items = Micropost.search_micropost(attribute = "content",str = params[:search]).paginate(page: params[:page])
    if @feed_items.empty?
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
    respond_to do |format|
      format.html { render "static_pages/home" }
      format.js
    end
  end
end
