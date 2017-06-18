class CreateUserMusicProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_music_profiles do |t|
      t.references :user, foreign_key: true, index: { unique: true }
      t.boolean :guitar_owned
      t.text :guitar_models_owned ###, array: true, default: []
      t.text :fav_composers ###, array: true, default: []
      t.text :fav_performers ###, array: true, default: []
      t.text :fav_periods ###, array: true, default: []

      t.timestamps
    end
  end
end
