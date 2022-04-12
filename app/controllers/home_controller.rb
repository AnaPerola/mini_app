class HomeController < ApplicationController 
  before_action :user_profile?

  def index
    if current_user
      @tasks = Task.where(share: true).last(3)
    else
      @tasks = Task.first(3)
    end
  end
end
