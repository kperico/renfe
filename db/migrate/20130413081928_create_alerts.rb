class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :name
      t.string :recipients
      t.string :from
      t.string :to
      t.date :when
      t.boolean :sent

      t.timestamps
    end
  end
end
