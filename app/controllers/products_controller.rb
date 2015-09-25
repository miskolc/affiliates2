class ProductsController < ApplicationController
  before_action :get_feed

  def index
    @products = @feed.products_on_page params[:page]
  end

  def show
    @product = @feed.products.find(params[:id])
  end

  private
    def get_feed
      @feed = current_user.feeds.find params[:feed_id]
    end
end
