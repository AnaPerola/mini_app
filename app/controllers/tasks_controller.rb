class TasksController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create destroy search]
  before_action :user_profile?
  before_action :find_task, only: %i[edit update show confirm_delete destroy delete_comment change_privacy]
  skip_before_action :verify_authenticity_token, only: %i[search]
  before_action :public?, except: %i[private_page find_task index create show new]

  def index
    @tasks = Task.where(share: true)
  end

  def show 
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    @task.user_id = current_user.id
    if @task.save
      flash[:notice] = 'Task created!'
      redirect_to task_path(@task)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:notice] = 'Task updated!'
      redirect_to task_path(@task)
    else
      render :edit
    end
  end

  def destroy
    if @task.destroy
      flash[:notice] = 'Task successfully destroyed!'
      redirect_to tasks_path
    else 
      redirect_to task_path(@task)
    end
  end

  def complete
  end

  def incomplete
  end

  def change_privacy
    @task.update(privacy_params)
    redirect_to @task
  end

  def private_page 
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :status, :priority, :share)
  end  

  def find_task
    @task = Task.find(params[:id])
  end

  def privacy_params
    params.require(:task).permit(:share)
  end

  def public?
    unless (current_user.id == @task.user_id)
      unless @task.share
        redirect_to private_page_task_path(@task)
      end
    end
  end

  def comment_params
  end 

  def sanitize_sql_like(string, escape_character = "\\")
    pattern = Regexp.union(escape_character, "%", "_")
    string.gsub(pattern) { |x| [escape_character, x].join }
  end
end

