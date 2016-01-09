class AddClientConfirmationToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :client_confirmation, :boolean
    add_column :offers, :admin_confirmation, :boolean
  end
end
