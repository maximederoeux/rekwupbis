class AddCreatorganizerToEvents < ActiveRecord::Migration
  def change
    add_column :events, :creatorganizer, :boolean
  end
end
