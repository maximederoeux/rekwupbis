class AddInterimToUsers < ActiveRecord::Migration
  def change
    add_column :users, :interim, :boolean
    add_column :users, :fixed, :boolean
    add_column :users, :leader, :boolean
    add_column :users, :time_per_week, :integer
  end
end
