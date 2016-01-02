class AddPartyToEvents < ActiveRecord::Migration
  def change
    add_column :events, :party, :boolean
    add_column :events, :dinner, :boolean
  end
end
