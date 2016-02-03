class AddIsCcToBoxes < ActiveRecord::Migration
  def change
    add_column :boxes, :is_cc, :boolean
    add_column :boxes, :is_ep, :boolean
    add_column :boxes, :is_eco, :boolean
    add_column :boxes, :is_wine, :boolean
    add_column :boxes, :is_cava, :boolean
    add_column :boxes, :is_twenty, :boolean
    add_column :boxes, :is_twentyfive, :boolean
    add_column :boxes, :is_fifty, :boolean
    add_column :boxes, :is_forty, :boolean
    add_column :boxes, :is_litre, :boolean
    add_column :boxes, :is_shot, :boolean
    add_column :boxes, :is_bep, :boolean
    add_column :boxes, :is_rekwup, :boolean
    add_column :boxes, :is_lln, :boolean
    add_column :boxes, :is_patro, :boolean
    add_column :boxes, :is_kpt, :boolean
    add_column :boxes, :is_empty, :boolean
  end
end
