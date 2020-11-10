class StaticPagesController < ApplicationController
  
  # GET / 
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  # GET /help(.:format)
  def help
  end
  
  # GET /about(.:format)
  def about
  end
  
  # GET /contact(.:format)
  def contact
  end
  
end
