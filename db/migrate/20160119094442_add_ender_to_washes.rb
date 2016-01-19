class AddEnderToWashes < ActiveRecord::Migration
  def change
    add_column :washes, :ender, :integer
  end
end
