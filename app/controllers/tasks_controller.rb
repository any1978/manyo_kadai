class TasksController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
      # @tasks = Task.all.order(created_at: :desc)
      # @tasks = Task.except(:end_date)
    if params[:sort && :direction]
      @tasks = Task.all.order(sort_column + ' ' + sort_direction)
    else
      @tasks = Task.all.order(created_at: :desc)
    end
    # @transactions = Transaction.paginate(page: params[:page], per_page: 8).order(sort_column + ' ' + sort_direction)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
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
    task = Task.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しました。"
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}」を削除しました。"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :end_date)
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "end_date"
  end
end
