class CommentsController < ApplicationController
  before_action :comment_owner?

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

  private 
    
  def comment_owner?
    @profile = Profile.find(params[:profile_id])
    if !current_user
      redirect_to root_path
    elsif (current_user.profile != @profile and !@profile.share )
      redirect_to root_path
    end
  end
end

