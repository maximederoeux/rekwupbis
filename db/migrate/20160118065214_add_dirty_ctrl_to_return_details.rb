class AddDirtyCtrlToReturnDetails < ActiveRecord::Migration
  def change
    add_column :return_details, :dirty_ctrl, :integer
    add_column :return_details, :sealed_ctrl, :integer
    add_column :return_details, :clean_ctrl, :integer
  end
end
