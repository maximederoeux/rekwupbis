class AddAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address, :string
    add_column :users, :postcode, :string
    add_column :users, :country, :string
    add_column :users, :vat, :string
    add_column :users, :phone, :string
    add_column :users, :gsm, :string
  end
end
