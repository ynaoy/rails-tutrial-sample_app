class UsersController < ApplicationController
before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                      :following, :followers]
before_action :correct_user,   only: [:edit, :update]
before_action :admin_user,     only: :destroy

  def index
    @users = User.search_user.paginate(page: params[:page])
    #@users = User.paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.json { render json: @users, status: 200 }
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    redirect_to root_url and return unless @user.activated?
    respond_to do |format|
      format.html
      format.json { render json: {user: @user, micropost: @microposts}, status: 200 }
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      respond_to do |format|
        format.html do
          @user.send_activation_email
          flash[:info] = "Please check your email to activate your account."
          redirect_to root_url
        end
        format.json { render json: @user, status: 200 }
      end
    else
      respond_to do |format|
        format.html { render 'new'}
        format.json { render json: @user.errors, status: 400}
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      respond_to do |format|
        format.html do
          flash[:success] = "Profile updated"
          redirect_to @user
        end
        format.json { render json: @user, status: 200 }
      end
    else
      respond_to do |format|
        format.html { render 'edit'}
        format.json { render json: @user.errors, status: 400}
      end
    end
  end

  def destroy
   User.find(params[:id]).destroy
   flash[:success] = "User deleted"
   redirect_to users_url
 end

 def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    respond_to do |format|
      format.html{ render 'show_follow'}
      format.json{ render json: @users, status: 200 }
    end
    #render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    respond_to do |format|
      format.html{ render 'show_follow'}
      format.json{ render json: @users, status: 200 }
    end
    #render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # beforeアクション

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
