class TransactionsController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
  end

  def new
    @transaction = Transaction.new
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

  def pay_item
    Payjp.api_key = 'sk_test_a309a0a09c01fc5695e76319'
    # Payjp.api_key = ENV[:payjp_key]
    # Payjp.open_timeout = 30 # optionally
    # Payjp.read_timeout = 90 # optionally

    card = {
      card: {
        number: params[:number],
        cvc: params[:cvc],
        exp_month: params[:exp_month],
        exp_year: '20' + params[:exp_year]
      }
    }

    result = Payjp::Token.create(
      card,
      {
        # テスト目的のトークン作成
        # テスト等の目的でトークンの作成処理をサーバーサイドで完結させたい場合、HTTPヘッダーに X-Payjp-Direct-Token-Generate: true を指定して本APIをリクエストすることで、カード情報を直接指定してトークンを作成することができます。この機能はテストモードでのみ利用可能です。
        'X-Payjp-Direct-Token-Generate': 'true'
      }
    )

    token = result.id

    # ex, create charge
    charge = Payjp::Charge.create(
      amount: @item.price,
      card: token,
      currency: 'jpy'
    )
  end
end
