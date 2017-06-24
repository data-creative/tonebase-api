class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.references :user, foreign_key: true
      t.references :instrument, foreign_key: true
      t.string :title, null: false
      t.text :description, null: false
      t.text :tags, array: true, default: [] # if moving away from PG, comment-out `, array: true, default: []` and place `serialize(:tags, Array)` in the Video model.

      t.timestamps
    end

    add_index :videos, [:user_id, :title], unique: true
    add_index :videos, :title
    add_index :videos, :tags
  end
end
