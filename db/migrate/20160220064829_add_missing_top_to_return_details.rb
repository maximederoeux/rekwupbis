class AddMissingTopToReturnDetails < ActiveRecord::Migration
  def change
    add_column :return_details, :missing_top, :integer
    add_column :return_details, :tagged_top, :integer
    add_column :return_details, :tagged_box, :integer
  end
end
