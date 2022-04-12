class MinusesController < ApplicationController 
  before_action :find_comment, :find_task, only: %i[create destroy]


  def create 
    if minused?
      Minuse.where(comment: @comment)[0].destroy
      @comment.update(score: (@comment.score + 1))
      flash[:notice] = 'Comment Unminused'
    elsif plused?
      Pluse.where(comment: @comment)[0].destroy
      @comment.update(score: (@comment.score - 1))
      flash[:notice] = 'Comment Unplused'
    else 
      @minus = Minuse.create(user: current_user, comment: @comment)
      @minus.save
      @comment.update(score: (@comment.score - 1))
      flash[:notice] = 'Comment Minused'
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

