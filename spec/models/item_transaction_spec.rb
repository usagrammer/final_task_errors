require "rails_helper"

RSpec.describe ItemTransaction, type: :model do
  before do
    @item_transaction = FactoryBot.build(:item_transaction)
  end
end
