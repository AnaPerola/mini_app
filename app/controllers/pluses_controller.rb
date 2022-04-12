class PlusesController < ApplicationController 
  before_action :find_comment, :find_task, only: %i[create]


  def create 
    if plused?
      Pluse.where(comment: @comment)[0].destroy
      @comment.update(score: (@comment.score - 1))
      flash[:notice] = 'Comment Unplused'
    elsif minused?  
      Minuse.where(comment: @comment)[0].destroy
      @comment.update(score: (@comment.score + 1))
      flash[:notice] = 'Comment Unminused'
    else
      @plus = Pluse.create(user: current_user, comment: @comment)
      @plus.save
      flash[:notice] = 'Comment Plused'
      @comment.update(score: (@comment.score + 1))
    end
    redirect_to task_path(@task)
  end

  private 

  def find_comment
    @comment = Comment.find(params[:comment_id])
  end

  def find_task
    @task = Task.find(params[:task_id])
  end 
end

