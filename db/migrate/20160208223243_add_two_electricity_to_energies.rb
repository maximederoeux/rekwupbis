class AddTwoElectricityToEnergies < ActiveRecord::Migration
  def change
    add_column :energies, :two_electricity, :decimal, :precision => 16, :scale => 4
    add_column :energies, :photo, :decimal, :precision => 16, :scale => 4
    add_column :energies, :two_photo, :decimal, :precision => 16, :scale => 4
    add_column :energies, :two_gaz, :decimal, :precision => 16, :scale => 4
    add_column :energies, :two_water, :decimal, :precision => 16, :scale => 4
    add_column :energies, :three_water, :decimal, :precision => 16, :scale => 4
    add_column :energies, :four_water, :decimal, :precision => 16, :scale => 4
  end
end
