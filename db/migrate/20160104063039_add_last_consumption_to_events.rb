class AddLastConsumptionToEvents < ActiveRecord::Migration
  def change
    add_column :events, :last_consumption, :integer
  end
end
