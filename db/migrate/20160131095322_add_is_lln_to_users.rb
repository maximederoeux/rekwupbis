class AddIsLlnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_lln, :boolean
    add_column :users, :lln_id, :integer
  end
end
