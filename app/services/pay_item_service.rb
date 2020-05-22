class PayItemService
  def self.pay_item(price, token)
    Payjp.api_key = "sk_test_a309a0a09c01fc5695e76319"
    charge = Payjp::Charge.create(
      amount: price,
      card: token,
      currency: "jpy",
    )
  end
end
