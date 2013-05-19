class Timestable < ActiveRecord::Migration
  def up
    add_column :alerts, :times, :text
  end

  def down
  end
end
