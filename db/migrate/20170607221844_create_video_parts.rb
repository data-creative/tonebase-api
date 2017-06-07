class CreateVideoParts < ActiveRecord::Migration[5.0]
  def change
    create_table :video_parts do |t|
      t.references :video, foreign_key: true
      t.string :source_url, null: false
      t.integer :number, null: false
      t.integer :duration, null: false

      t.timestamps
    end

    add_index :video_parts, :number
  end
end
