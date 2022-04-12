class ApplicationController < ActionController::Base

  def user_profile?
    if current_user && current_user.profile == nil
      redirect_to new_profile_path
    end
  end

  private

  def plused?
    Pluse.where(user: current_user, comment: @comment).exists?
  end

  def minused?
    Minuse.where(user: current_user, comment: @comment).exists?
  end
end
