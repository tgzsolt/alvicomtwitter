class HomeController < ApplicationController
  
  def index
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 8)
    end
  end
  def about
  end
  def contact
  end
end
