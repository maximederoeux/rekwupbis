class AddIsNamurToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_namur, :boolean
  end
end
