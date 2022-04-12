class TasksController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create destroy search]
  before_action :user_profile?
  before_action :find_task, only: %i[edit update show confirm_delete destroy delete_comment]
  skip_before_action :verify_authenticity_token, only: %i[search]
    
  def index
  end

  def show 
  end

  def new
  end

  def create
  end

  def edit
  end

  def update 
  end

  def destroy
  end

  def complete
  end

  def incomplete
  end

  private

  def task_params
  end  

  def comment_params
  end 

  def sanitize_sql_like(string, escape_character = "\\")
    pattern = Regexp.union(escape_character, "%", "_")
    string.gsub(pattern) { |x| [escape_character, x].join }
  end
end

