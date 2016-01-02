class AddCreatorIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :creator_id, :integer
    add_column :events, :organizer_id, :integer
  end
end
