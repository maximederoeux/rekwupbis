class AddConfirmationInvoiceToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :confirmation_invoice, :boolean
  end
end
