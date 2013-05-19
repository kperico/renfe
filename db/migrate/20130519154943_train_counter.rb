class TrainCounter < ActiveRecord::Migration
  def up
    add_column :alerts, :matches, :integer, default: 0
  end

  def down
    remove_column :alerts, :matches, :integer
  end
end
