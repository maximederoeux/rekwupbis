class ChangeDecimalInEnergy < ActiveRecord::Migration
  def change
  	change_column :energies, :water, :decimal, :precision => 16, :scale => 4
  	change_column :energies, :gaz, :decimal, :precision => 16, :scale => 4
  	change_column :energies, :electricity, :decimal, :precision => 16, :scale => 4
  end
end
