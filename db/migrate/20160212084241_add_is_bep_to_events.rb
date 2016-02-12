class AddIsBepToEvents < ActiveRecord::Migration
  def change
    add_column :events, :is_bep, :boolean
  end
end
