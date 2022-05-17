class CommentsController < ApplicationController
  before_action :comment_owner?, only: %i[index]
  before_action :set_comment, only: %i[show update destroy]

  def index
    @comments = Comment.where(user: current_user)
    if params[:order].in? %w[new old]
      case params[:order]
      when 'new'
        @comments.order!(created_at: :desc)
      when 'old'
        @comments.order!(:created_at)
      end
    end
  end 

  def create
    @comment = Comment.create(comments_params)
    if @comment.save
      flash[:notice] = 'Comment Created!'
    else 
      flash[:notice] = 'Error'
      redirect_to :new
    end
  end

  def new 
  end

  def show 
  end

  def edit
  end

  def update
    @comment.update(comments_params)
    if @comment.save
      flash[:notice] = 'Comment Updated!'
    else
      flash[:notice] = 'Error'
      redirect_to comment_path
    end
  end
  
  def destroy
    if @comment.destroy
      flash[:notice] = 'Comment destroyed!'
    else
      flash[:notice] = 'Error'
      redirect_to comment_path
    end
  end
  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comments_params
    params.require(:commet).permit(:body, :task_id, :user_id)
  end

  def comment_owner?
    @profile = Profile.find(params[:profile_id])
    if !current_user
      redirect_to root_path
    elsif (current_user.profile != @profile and !@profile.share )
      redirect_to root_path
    end
  end
end

