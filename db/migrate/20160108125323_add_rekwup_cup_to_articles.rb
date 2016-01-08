class AddRekwupCupToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :rekwup_cup, :boolean
  end
end
