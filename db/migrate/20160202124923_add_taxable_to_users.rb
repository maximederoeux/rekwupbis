class AddTaxableToUsers < ActiveRecord::Migration
  def change
    add_column :users, :taxable, :boolean
    add_column :users, :company_number, :string
  end
end
