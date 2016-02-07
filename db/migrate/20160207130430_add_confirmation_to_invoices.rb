class AddConfirmationToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :confirmation, :boolean
    add_column :invoices, :after_event, :boolean
    add_column :invoices, :confirmation_paid, :boolean
    add_column :invoices, :after_event_paid, :boolean
  end
end
