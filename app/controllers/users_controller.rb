class UsersController < ApplicationController
  # helper_method :sort_column, :sort_direction
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only:[:show, :edit, :update, :destroy]
  before_action :authenticate_user, only:[:show, :edit, :update, :destroy]
  
  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    # sort_column = params[:column].presence 
    # if params[:sort && :direction]
    #   @user.tasks = @user.tasks.all.order(sort_column + ' ' + sort_direction)
    # else
    #   @user.tasks = @user.tasks.all.order(created_at: :desc)
    # end
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
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:user_name, :email, :password,
                                  :password_confirmation)
    end

    def ensure_correct_user
      @user = User.find(params[:id])
      if current_user.admin?
      elsif current_user.id != @user.id
        flash[:notice] = "権限がありません"
        redirect_to tasks_path
      end
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end

end
