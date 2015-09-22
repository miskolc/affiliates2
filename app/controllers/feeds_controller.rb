class FeedsController < ApplicationController
  def create
    current_user.feeds.create feed_params
    redirect_to user_path current_user
  end

  private
    def feed_params
      params.require(:feed).permit({:file => []})
    end
end
