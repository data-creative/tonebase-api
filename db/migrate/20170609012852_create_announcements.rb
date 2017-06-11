class CreateAnnouncements < ActiveRecord::Migration[5.0]
  def change
    create_table :announcements do |t|
      t.string :title, null: false
      t.text :content
      t.string :url
      t.string :image_url
      t.boolean :broadcast, null: false, default: false

      t.timestamps
    end

    add_index :announcements, :title, unique: true
    add_index :announcements, :broadcast
  end
end
