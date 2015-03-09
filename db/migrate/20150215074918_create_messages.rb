class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :title
      t.text :message

      t.timestamps null: false
    end
  end
end
