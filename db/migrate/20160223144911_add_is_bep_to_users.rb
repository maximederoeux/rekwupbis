class AddIsBepToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_bep, :boolean
  end
end
