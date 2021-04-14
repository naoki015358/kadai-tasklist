class TasksController < ApplicationController
  before_action :require_user_logged_in
  # before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def index

      @tasks = current_user.tasks
  end

  def show
      
      
  end

  def new
       @task =Task.new
      
  end

  def create
      # @task = Task.new(task_params)
      @task = current_user.tasks.build(task_params)
      
      if @task.save
          flash[:success] = 'task　が投稿されました'
          redirect_to root_url
      else
        @tasks = current_user.tasks
          flash.now[:danger] = 'task　が投稿されませんでした'
          render :new
      end
  end

  def edit
  
  end

  def update
      
      
      if @task.update(task_params)
          flash[:success] = 'task は正常に編集されました'
          redirect_to @task
      else
          flash.now[:danger] = 'task は編集されませんでした'
          render :edit
      end
  end

  def destroy
    
      @task.destroy
      
      flash[:success] = 'task は正常に削除されました'
      redirect_to root_url
  end
  
  private
  
  
  def task_params
      params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
end