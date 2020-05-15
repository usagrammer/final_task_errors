class ItemsController < ApplicationController
  before_action :item_params, only: :create

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      return redirect_to root_path
    end
    redirect_to new_item_path
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(
      :image,
      :name,
      :info,
      :category_id,
      :status_id,
      :shipping_fee_id,
      :prefecture_id,
      :delivery_date_id,
      :price
    ).merge(user_id: current_user.id)
  end
end
