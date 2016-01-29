class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :doc_number
      t.integer :offer_id
      t.integer :client_id
      t.boolean :doc_invoice
      t.boolean :doc_credit

      t.timestamps null: false
    end
  end
end
