class CreateUserViewVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :user_view_videos do |t|
      t.references :user, foreign_key: true
      t.references :video, foreign_key: true

      t.timestamps
    end
  end
end
