class TasksController < ApplicationController
  def index
      @tasks = Task.all
  end

  def show
      @task = Task.find(params[:id])
  end

  def new
      @task =Task.new
  end

  def create
      @task = Task.new(task_params)
      
      if @task.save
          flash[:success] = 'task　が投稿されました'
          redirect_to @task
      else
          flash.now[:danger] = 'task　が投稿されませんでした'
          render :new
      end
  end

  def edit
      @task =Task.find(params[:id])
  end

  def update
      @task = Task.find(params[:id])
      
      if @task.update(task_params)
          flash[:success] = 'task は正常に編集されました'
          redirect_to @task
      else
          flash.now[:danger] = 'task は編集されませんでした'
          render :edit
      end
  end

  def destroy
      @task = Task.find(params[:id])
      @task.destroy
      
      flash[:success] = 'task は正常に削除されました'
      redirect_to tasks_url
  end
  
  private
  
  def task_params
      params.require(:task).permit(:content)
  end
  
end
