class ProductsController < ApplicationController
  before_action :get_feed
  before_action :get_product, except: [:index, :new, :create]

  def index
    @products = @feed.products_on_page params[:page]
  end

  def show
  end

  def edit
  end

  def update
    @product.update_attributes product_params
    redirect_to edit_user_feed_product_path(current_user, @feed, @product, page: params[:page] )
  end

  def destroy
    @product.destroy
    redirect_to user_feed_products_path(current_user, @feed, page: params[:page])
  end

  private
    def get_feed
      @feed = current_user.feeds.find params[:feed_id]
    end

    def get_product
      @product = @feed.products.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :url, :price)
    end
end
