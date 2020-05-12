class ItemsController < ApplicationController

  before_action :item_params, only: :create

  def index

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
    )
  end

end
