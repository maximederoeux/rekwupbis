class AddCommentToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :comment, :text
  end
end
