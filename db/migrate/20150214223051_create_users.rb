class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :username
      t.string :password
      t.string :password_confirm

      t.timestamps null: false
    end
  end
end
