namespace :paypay do
  desc "payjpのテスト"
  task :pay do
    require 'payjp'
    Payjp.api_key = 'sk_test_a309a0a09c01fc5695e76319'
    Payjp.open_timeout = 30 # optionally
    Payjp.read_timeout = 90 # optionally


    result = Payjp::Token.create({
      :card => {
        :number => '4242424242424242',
        :cvc => '123',
        :exp_month => '2',
        :exp_year => '2024'
      }},
      {
        'X-Payjp-Direct-Token-Generate': 'true'
      } 
    )

    token = result.id

    # ex, create charge
    charge = Payjp::Charge.create(
      :amount => 3500,
      :card => token,
      :currency => 'jpy',
    )
  end

end
