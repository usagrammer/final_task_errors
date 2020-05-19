class TransactionsController < ApplicationController


  def index
    @item = Item.find(params[:item_id])
  end


  def create
    binding.pry
    @item = Item.find(params[:item_id])
    
    @transaction = Transaction.new(transaction_params)
  end



  private
  def transaction_params
    params.require(:transaction).permit(:item_id, :token).merge(user_id: current_user.id)
  end


  # def payjp
  #   Payjp.charges.create({
  #       pk_test_530d79abed1768b5d8674052
  #       card: "payjpToken",
  #       amount: 3000,
  #       currency: "jpy",
  #     });
  # end

end
