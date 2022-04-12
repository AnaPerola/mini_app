class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :public?, except: %i[private_page]
 
  def show 
  end

  def new
    @profile = Profile.new
  end

  def create 
    @profile = Profile.create(profile_params)
    @profile.user = current_user
    current_user.profile_id = @profile.id
    if @profile.save
      flash[:notice] = 'Profile Created!'
      redirect_to @profile
    else
      render :new
    end
  end

  def edit 
  end

  def update
    if @profile.update(profile_params)
      flash[:notice] = 'Task Updated!'
      redirect_to @profile
    else
      render :edit
    end 
  end

  def change_privacy
    @profile.update(privacy_params)
    redirect_to @profile
  end

  def private_page 
  end

  private 

  def profile_params
  end 

  def privacy_params
    params.require(:profile).permit(:share)
  end

  def find_profile
    @profile = Profile.find(params[:id])
  end

  def public?
    unless (current_user.profile == @profile)
      unless @profile.share
        redirect_to private_page_profile_path(@profile)
      end
    end
  end

end
  
