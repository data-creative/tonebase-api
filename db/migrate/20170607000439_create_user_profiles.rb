class CreateUserProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_profiles do |t|
      t.references :user, foreign_key: true, index: { unique: true }
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.text :bio
      t.string :image_url
      t.string :hero_url
      t.integer :birth_year
      t.text :professions

      t.timestamps
    end
  end
end
