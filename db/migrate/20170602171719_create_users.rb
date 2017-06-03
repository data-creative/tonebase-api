class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password, null: false
      t.boolean :confirmed, null: false
      t.boolean :visible, null: false
      t.string :role, null: false
      t.string :access_level, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.text :bio
      t.string :image_url
      t.string :hero_url

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :confirmed
    add_index :users, :visible
    add_index :users, :role
    add_index :users, :access_level
  end
end
