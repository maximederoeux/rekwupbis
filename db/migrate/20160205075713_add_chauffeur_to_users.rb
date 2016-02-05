class AddChauffeurToUsers < ActiveRecord::Migration
  def change
    add_column :users, :chauffeur, :boolean
  end
end
