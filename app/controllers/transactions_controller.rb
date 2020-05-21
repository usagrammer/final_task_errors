class TransactionsController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])
    pay_item
    @transaction = Transaction.new(transaction_params)
    @transaction.save
    redirect_to root_path
  end

  private

  def transaction_params
    params.permit(:item_id).merge(user_id: current_user.id)
  end

  # def token_params
  #   params.permit(:token)
  # end

  
  def pay_item
    Payjp.api_key = 'sk_test_a309a0a09c01fc5695e76319'
    charge = Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
  end

end
