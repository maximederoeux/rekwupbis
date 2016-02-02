class AddDepositEventToEvents < ActiveRecord::Migration
  def change
    add_column :events, :deposit_event, :decimal
  end
end
