class AddIsLlnToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :is_lln, :boolean
    add_column :articles, :is_patro, :boolean
    add_column :articles, :is_bep, :boolean
    add_column :articles, :is_cc, :boolean
    add_column :articles, :is_ep, :boolean
    add_column :articles, :is_eco, :boolean
    add_column :articles, :is_wine, :boolean
    add_column :articles, :is_cava, :boolean
  end
end
