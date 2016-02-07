class AddTotalHtvaToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :total_htva, :decimal, :precision => 12, :scale => 2
    add_column :invoices, :total_tva, :decimal, :precision => 12, :scale => 2
    add_column :invoices, :total_tvac, :decimal, :precision => 12, :scale => 2
  end
end
