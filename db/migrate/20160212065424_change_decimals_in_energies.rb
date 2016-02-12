class ChangeDecimalsInEnergies < ActiveRecord::Migration
  def change
 	change_column :energies, :water, :decimal, :precision => 8, :scale => 3
 	change_column :energies, :two_water, :decimal, :precision => 8, :scale => 3
 	change_column :energies, :three_water, :decimal, :precision => 8, :scale => 3
 	change_column :energies, :four_water, :decimal, :precision => 8, :scale => 3
  change_column :energies, :gaz, :decimal, :precision => 8, :scale => 3
  change_column :energies, :two_gaz, :decimal, :precision => 8, :scale => 3
  change_column :energies, :electricity, :decimal, :precision => 8, :scale => 2
  change_column :energies, :two_electricity, :decimal, :precision => 8, :scale => 2
  change_column :energies, :photo, :decimal, :precision => 8, :scale => 2
  change_column :energies, :two_photo, :decimal, :precision => 8, :scale => 2
  end
end
