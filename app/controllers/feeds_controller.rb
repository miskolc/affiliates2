class FeedsController < ApplicationController
  def create
    feed = current_user.feeds.create feed_params
    ParserWorker.perform_async feed.id
    
    redirect_to user_path current_user
  end

  private
    def feed_params
      params.require(:feed).permit({:file => []})
    end
end
