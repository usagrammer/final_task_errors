class TransactionsController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])
    binding.pry
    @transaction = Transaction.new(transaction_params)
    @transaction.save
    redirect_to root_path
  end



  private

  def transaction_params
    params.require(:transaction).permit(:item_id, :token).merge(user_id: current_user.id)
  end


  def pay_item
    Payjp.api_key = 'sk_test_a309a0a09c01fc5695e76319'
    # Payjp.api_key = ENV[:payjp_key]
    # Payjp.open_timeout = 30 # optionally
    # Payjp.read_timeout = 90 # optionally

    

    # ex, create charge
    charge = Payjp::Charge.create(
      amount: @item.price,
      card: token,
      currency: 'jpy'
    )
  end

end
