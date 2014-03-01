class Admin::UsersController < AdminController
  
  def index
    @q = User.ransack(params[:q])
    @users = User.all
    @users = @q.result.page(params[:page]).per(30)
  end
  
  def show
    @user = User.find(params[:id])
  end

end