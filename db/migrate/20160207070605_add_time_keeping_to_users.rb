class AddTimeKeepingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :time_keeping, :boolean
  end
end
