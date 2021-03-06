class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :introduction
      t.string :sex
      t.string :password_digest
      t.string :remember_digest
      t.boolean :admin, default: false, null: false
      t.boolean :notification, default: false

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
