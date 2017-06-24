class CreateUserMusicProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_music_profiles do |t|
      t.references :user, foreign_key: true, index: { unique: true }
      t.boolean :guitar_owned
      t.text :guitar_models_owned, array: true, default: [] # if moving away from PG, comment-out `, array: true, default: []` and place `serialize(:guitar_models_owned, Array)` in the model.
      t.text :fav_composers, array: true, default: []  # if moving away from PG, comment-out `, array: true, default: []` and place `serialize(:fav_composers, Array)` in the model.
      t.text :fav_performers, array: true, default: []  # if moving away from PG, comment-out `, array: true, default: []` and place `serialize(:fav_performers, Array)` in the model.
      t.text :fav_periods, array: true, default: []  # if moving away from PG, comment-out `, array: true, default: []` and place `serialize(:fav_periods, Array)` in the model.

      t.timestamps
    end
  end
end
