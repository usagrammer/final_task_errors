class ItemsController < ApplicationController

  before_action :item_params, only: :create

  def index

  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      redirect_to new_item_path
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :image,
      :name,
      :info,
      :category_id,
      :status_id,
      :burden_id,
      :prefecture_id,
      :delivery_date_id,
      :price
    )
  end

end
