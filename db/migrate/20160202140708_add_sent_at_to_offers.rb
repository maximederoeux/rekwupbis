class AddSentAtToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :sent_at, :datetime
  end
end
