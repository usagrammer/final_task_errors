class ItemsController < ApplicationController
  before_action :item_params, only: :create
  before_action :set_item, only: [:show, :edit]

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
  end

  def edit
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to root_path
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to item_path
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

  def set_item
    @item = Item.find(params[:id])
  end
end
