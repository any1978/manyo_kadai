class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:create, :show, :edit, :update, :destroy]
  before_action :admin_user, only: [:create, :destroy, :edit, :update]
  # before_action :ensure_correct_user, only:[:show, :create, :edit, :update, :destroy]
  # before_action :admin_user, only: :destroy

  # GET /users
  def index
    @users = User.all
    @tasks = Task.all.includes(:user)
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
    # @user.tasks = @user.tasks.page(params[:page]).per(7)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = Use.new(user_params)
      if user.save
        redirect_to admin_users_path, notice: "ユーザー「#{@user.user_name}」を登録しました"
      else
        render :new
      end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to admin_users_path(@user), notice: "ユーザー「#{@user.user_name}」を更新しました"
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    if @user.destroy
    redirect_to admin_users_path, notice: "ユーザー「#{@user.user_name}」を削除しました"
    else
      redirect_to admin_users_path, notice: "管理者「#{@user.user_name}」は削除できません"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:user_name, :email, :admin, :password,
                                  :password_confirmation)
    end

    def admin_user
      if current_user.admin?
      else
        redirect_to root_path 
        flash[:notice] = "あなたは管理者ではありません"
      end
    end

    # def ensure_correct_user
    #   @user = User.find(params[:id])
    #   if current_user.admin != @user
    #     flash[:notice] = "権限がありません"
    #     redirect_to tasks_path
    #   end
    # end

    # def admin_user
    #   redirect_to(root_path) unless current_user.admin?
    # end
end
