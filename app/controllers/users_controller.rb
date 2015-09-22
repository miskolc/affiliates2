class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :authorize_resource!, only: [:show]

  def show
    @feed = current_user.feeds.build
  end

  private

    def authorize_resource!
      if !params[:id]
        redirect_to user_path current_user
        flash[:alert] = "Hey! Hackers are not allowed on our site ;)"
      elsif current_user.id != params[:id].to_i
        redirect_to user_path current_user
        flash[:alert] = "Hey! Stealing other people's property is illegal. Data is private property!"
      end
    end
end
