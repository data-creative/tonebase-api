class CreateAnnouncements < ActiveRecord::Migration[5.0]
  def change
    create_table :announcements do |t|
      t.string :title, null: false
      t.text :content
      t.string :url
      t.string :image_url

      t.timestamps
    end

    add_index :announcements, :title, unique:true
  end
end
