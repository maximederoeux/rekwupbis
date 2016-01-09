class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :event_id
      t.integer :organizer_id

      t.timestamps null: false
    end
  end
end
