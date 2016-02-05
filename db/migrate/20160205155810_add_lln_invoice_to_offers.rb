class AddLlnInvoiceToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :lln_invoice, :boolean
  end
end
