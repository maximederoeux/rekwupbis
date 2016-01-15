class DropTableReturn < ActiveRecord::Migration

  def up
    drop_table :returns
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
