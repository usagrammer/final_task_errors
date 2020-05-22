class TransactionsController < ApplicationController
  before_action :select_item, only: [:index, :create]

  def index
  end

  def create
    pay_item
    @transaction = Transaction.new(transaction_params)
    @transaction.save
    redirect_to root_path
  end

  private

  def transaction_params
    params.permit(:item_id).merge(user_id: current_user.id)
  end

  def pay_item
    PayItemService.pay_item(@item.price, params[:token])
  end

  def select_item
    @item = Item.find(params[:id])
  end
end
