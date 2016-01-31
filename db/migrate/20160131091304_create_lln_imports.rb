class CreateLlnImports < ActiveRecord::Migration
  def change
    create_table :lln_imports do |t|
      t.string :circle
      t.integer :lln_twentyfive
      t.integer :lln_fifty
      t.integer :lln_litre
      t.integer :empty_box
      t.integer :kpt_box
      t.integer :return_box

      t.timestamps null: false
    end
  end
end
