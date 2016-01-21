class AddSendEmailToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :send_email, :boolean
  end
end
