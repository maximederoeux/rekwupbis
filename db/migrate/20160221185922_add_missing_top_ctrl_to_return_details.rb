class AddMissingTopCtrlToReturnDetails < ActiveRecord::Migration
  def change
    add_column :return_details, :missing_top_ctrl, :integer
    add_column :return_details, :tagged_top_ctrl, :integer
    add_column :return_details, :tagged_box_ctrl, :integer
  end
end
