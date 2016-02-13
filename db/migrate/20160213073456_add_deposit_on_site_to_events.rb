class AddDepositOnSiteToEvents < ActiveRecord::Migration
  def change
    add_column :events, :deposit_on_site, :decimal, :precision => 4, :scale => 2
  end
end
