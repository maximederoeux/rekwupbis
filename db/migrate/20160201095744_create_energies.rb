class CreateEnergies < ActiveRecord::Migration
  def change
    create_table :energies do |t|
      t.decimal :water, :precision => 8, :scale => 4
      t.decimal :gaz, :precision => 8, :scale => 4
      t.decimal :electricity, :precision => 8, :scale => 4

      t.timestamps null: false
    end
  end
end
