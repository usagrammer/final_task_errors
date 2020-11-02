class ItemsController < ApplicationController
  before_action :select_item, only: [:show, :edit, :update, :destroy, :purchase_confirm, :purchase]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :purchase_confirm, :purchase]
  before_action :sold_item, only: [:purchase_confirm, :purchase]
  before_action :current_user_has_not_card, only: [:purchase_confirm, :purchase]
  before_action :set_item_form, only: [:edit, :update]
  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item_form = ItemForm.new
  end
  
  def create
    @item_form = ItemForm.new(item_form_params)
    # バリデーションで問題があれば、保存はされず「商品出品画面」を再描画
    if @item_form.valid?
      @item_form.save
      return redirect_to root_path
    end
    # アクションのnewをコールすると、エラーメッセージが入った@itemが上書きされてしまうので注意
    render 'new'
  end

  def purchase
    ## 購入履歴オブジェクトを定義
    item_transaction = ItemTransaction.new(item_id: @item.id, user_id: current_user.id)

    ## 購入履歴オブジェクトに紐づく配送先オブジェクトを定義
    @address = item_transaction.build_address(address_params)
    if @address.valid?
      ## 配送先を保存できるとき
      Payjp.api_key = ENV['PAYJP_SK']      
      Payjp::Charge.create(
        amount: @item.price,
        customer: current_user.card.customer_token,  ## 顧客のトークンを渡す
        currency: 'jpy'
      )

      @address.save
      redirect_to root_path
    else
      ## 配送先を保存できないとき
      redirect_to purchase_confirm_item_path(@item)
    end
  end

  def purchase_confirm
    @address = Address.new
  end

  def show
    @comments = @item.comments.includes(:user)
    @comment = Comment.new
  end

  def edit
    return redirect_to root_path if current_user.id != @item.user.id
  end

  def update
    render 'edit' unless current_user.id == @item.user.id
    @item_form = ItemForm.new(item_form_params)
    if @item_form.update(item_form_params, @item)
      return redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy if current_user.id == @item.user.id
    redirect_to root_path
  end

  private

  def item_form_params
    ## require(:item) → require(:item_form)
    params.require(:item_form).permit(
      :name,
      :info,
      :category_id,
      :tag_name,
      :sales_status_id,
      :shipping_fee_status_id,
      :prefecture_id,
      :scheduled_delivery_id,
      :price,
      {images: []}
    ).merge(user_id: current_user.id)
  end

  def select_item
    @item = Item.find(params[:id])
  end

  def address_params
    params.permit(
      :postal_code,
      :prefecture,
      :city,
      :addresses,
      :building,
      :phone_number
    )
  end

  def set_item_form
    item_attributes = @item.attributes
    @item_form = ItemForm.new(item_attributes)
  end
  
  def sold_item
    redirect_to item_path(@item), alert: "売り切れの商品です" if @item.item_transaction.present?
  end
  
  def current_user_has_not_card
    redirect_to new_card_path, alert: "クレジットカードが登録されていません" unless current_user.card.present?
  end
end
