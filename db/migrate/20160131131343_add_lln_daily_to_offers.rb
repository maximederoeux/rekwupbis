class AddLlnDailyToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :lln_daily, :boolean
  end
end
