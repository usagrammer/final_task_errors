class TransactionsController < ApplicationController


  def index
    @item = Item.find(params[:item_id])
  end


  def create
    @item = Item.find(params[:item_id])
    @transaction = Transaction.new(transaction_params)
  end



  private

  def transaction_params
    params.require(:transaction).permit(:item_id, :user_id, :token)
  end

end
