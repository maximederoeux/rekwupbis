class AddIndividualToUsers < ActiveRecord::Migration
  def change
    add_column :users, :individual, :boolean
    add_column :users, :company, :boolean
    add_column :users, :non_profit, :boolean
    add_column :users, :institution, :boolean
    add_column :users, :admin, :boolean
    add_column :users, :staff, :boolean
    add_column :users, :client, :boolean
    add_column :users, :company_name, :string
    add_column :users, :first_name, :string
  end
end
