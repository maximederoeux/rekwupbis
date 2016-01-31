class AddLlnTwentyfiveToBoxes < ActiveRecord::Migration
  def change
    add_column :boxes, :lln_twentyfive, :boolean
    add_column :boxes, :lln_fifty, :boolean
    add_column :boxes, :lln_litre, :boolean
  end
end
