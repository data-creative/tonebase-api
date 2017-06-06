class CreateUserFavoriteVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :user_favorite_videos do |t|
      t.references :user, foreign_key: true
      t.references :video, foreign_key: true

      t.timestamps
    end

    add_index :user_favorite_videos, [:user_id, :video_id], unique: true
  end
end
