class AddIsLlnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :is_lln, :boolean
    add_column :events, :lln_year, :integer
  end
end
