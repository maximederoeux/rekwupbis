class AddIsPaletteToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :is_palette, :boolean
  end
end
