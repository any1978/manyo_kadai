class TasksController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
      # @tasks = Task.all.order(created_at: :desc)
      # @tasks = Task.except(:end_date)
    if params[:sort && :direction]
      @tasks = Task.all.order(sort_column + ' ' + sort_direction)
    else
      @tasks = Task.all.order(created_at: :desc)
    end
    # @transactions = Transaction.paginate(page: params[:page], per_page: 8).order(sort_column + ' ' + sort_direction)
    
    if params[:name].present?
      @tasks = @tasks.get_by_name params[:name]
    end
    if params[:status].present?
      @tasks = @tasks.get_by_status params[:status]
    elsif 
      @tasks = @tasks.all
    end
  
  
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_url, notice: "タスク「#{@task.name}」を登録しました。"
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

  # def search
  #   # binding.irb
  #   @tasks = Task.search(params[:search])
  #   render :index
  # end

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

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : ("end_date" && "priority")
    # Task.column_names.include?(params[:sort]) ? params[:sort] : "priority"
  end
end
