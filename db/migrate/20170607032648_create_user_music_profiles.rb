class CreateUserMusicProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_music_profiles do |t|
      t.references :user, foreign_key: true, index: { unique: true }
      t.boolean :guitar_owned
      t.text :guitar_models_owned
      t.text :fav_composers
      t.text :fav_performers
      t.text :fav_periods

      t.timestamps
    end
  end
end
