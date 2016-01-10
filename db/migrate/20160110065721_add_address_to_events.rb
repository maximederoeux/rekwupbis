class AddAddressToEvents < ActiveRecord::Migration
  def change
    add_column :events, :address, :string
    add_column :events, :delivery_date, :date
    add_column :events, :return_date, :date
    add_column :events, :contact, :string
    add_column :events, :phone, :string
  end
end
