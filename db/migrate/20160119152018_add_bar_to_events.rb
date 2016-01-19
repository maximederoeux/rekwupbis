class AddBarToEvents < ActiveRecord::Migration
  def change
    add_column :events, :bar, :integer
    add_column :events, :beertap, :integer
  end
end
