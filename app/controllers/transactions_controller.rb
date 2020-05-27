class TransactionsController < ApplicationController
  before_action :select_item, only: [:index, :create]

  def index
  end

  def create
    pay_item
    @item_transaction = ItemTransaction.new(item_transaction_params)
    @item_transaction.save
    redirect_to root_path
  end

  private

  def item_transaction_params
    params.permit(:item_id).merge(item_id: @item.id, user_id: current_user.id)
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SK"]
    charge = Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: "jpy",
    )
  end

  def select_item
    @item = Item.find(params[:item_id])
  end
end
