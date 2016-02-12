class AddIsAgeToBoxes < ActiveRecord::Migration
  def change
    add_column :boxes, :is_age, :boolean
    add_column :boxes, :is_champagne, :boolean
  end
end
