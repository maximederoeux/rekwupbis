class AddIsCompleteToEvents < ActiveRecord::Migration
  def change
    add_column :events, :is_complete, :boolean
  end
end
