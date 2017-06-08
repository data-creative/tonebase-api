class CreateVideoScores < ActiveRecord::Migration[5.0]
  def change
    create_table :video_scores do |t|
      t.references :video, foreign_key: true
      t.string :image_url, null: false
      t.integer :starts_at, null: false
      t.integer :ends_at, null: false

      t.timestamps
    end
  end
end
