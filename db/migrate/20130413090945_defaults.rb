class Defaults < ActiveRecord::Migration
  def up
    change_column :alerts, :sent, :boolean, default: false
  end

  def down
  end
end
