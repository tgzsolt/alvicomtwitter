class LikesController < ApplicationController
  before_filter :signed_in_user
  
  def create
    @micropost = Micropost.find(params[:micropost_id])
    current_user.like!(@micropost)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js {
        flash.now[:success] = "Micropost liked!"        
      }
    end
  end

  def destroy
    @micropost = Like.find(params[:id]).micropost
    current_user.unlike!(@micropost)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js {
            flash.now[:success] = "Micropost disliked!"
      }
    end
  end
end