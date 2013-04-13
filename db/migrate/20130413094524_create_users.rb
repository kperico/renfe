class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :passwd
      t.boolean :admin, default: false

      t.timestamps
    end

    User.create(login: 'pablo', passwd: 'pableras', admin: true)
  end
end
