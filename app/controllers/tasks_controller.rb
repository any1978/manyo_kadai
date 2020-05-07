class TasksController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only:[:show, :edit, :update, :destroy]
  before_action :authenticate_user

  def index
    sort_column = params[:column].presence 

    if params[:sort && :direction]
      @tasks = Task.all.order(sort_column + ' ' + sort_direction)
    else
      @tasks = Task.all.order(created_at: :desc)
    end

    if params[:name].present?
      @tasks = @tasks.get_by_name params[:name]
    end
    if params[:status].present?
      @tasks = @tasks.get_by_status params[:status]
    elsif 
      @tasks = @tasks.all
    end
  
    @tasks = @tasks.page(params[:page]).per(7)
  
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスク「#{@task.name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}」を削除しました。"
  end



  private

  def task_params
    params.require(:task).permit(:name, :description, :end_date, :status, :priority)
  end

  def set_task
    # binding.irb
    @task = Task.find(params[:id])
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def ensure_correct_user
    @task = Task.find(params[:id])
    if @current_user_id != @task.user.id
      flash[:notice] = "権限がありません"
      redirect_to root_path
    # elsif current_user.id == current_user.admin
    end
  end



end
