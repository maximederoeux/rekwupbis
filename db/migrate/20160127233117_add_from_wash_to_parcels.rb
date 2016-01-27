class AddFromWashToParcels < ActiveRecord::Migration
  def change
    add_column :parcels, :from_wash, :boolean
    add_column :parcels, :from_return, :boolean
  end
end
