class AddAgeToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :age, :boolean
    add_column :articles, :champagne, :boolean
    add_column :articles, :pile_smallbox, :integer
  end
end
