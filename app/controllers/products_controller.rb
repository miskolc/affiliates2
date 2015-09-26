class ProductsController < ApplicationController
  before_action :get_feed

  def index
    @products = @feed.products_on_page params[:page]
  end

  def show
    @product = @feed.products.find(params[:id])
  end

  def edit
    @product = @feed.products.find(params[:id])
  end

  def update
    @product = @feed.products.find(params[:id])
    @product.update_attributes product_params
    redirect_to edit_user_feed_product_path(current_user, @feed, @product)
  end

  def destroy
    @product = @feed.products.find(params[:id])
    @product.destroy
    redirect_to user_feed_products_path(current_user, @feed, params[:page])
  end

  private
    def get_feed
      @feed = current_user.feeds.find params[:feed_id]
    end

    def product_params
      params.require(:product).permit(:title, :url, :price)
    end
end
