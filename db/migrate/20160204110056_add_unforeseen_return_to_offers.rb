class AddUnforeseenReturnToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :unforeseen_return, :boolean
  end
end
