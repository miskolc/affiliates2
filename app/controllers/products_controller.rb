class ProductsController < ApplicationController
  def index
    @feed = current_user.feeds.find params[:feed_id]
    @products = @feed.products_on_page params[:page]
  end
end
