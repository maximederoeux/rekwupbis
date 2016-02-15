class AddLlnWeekInvoiceToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :lln_week_invoice, :boolean
  end
end
