class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :broadcastable, polymorphic: true, null: false
      t.string :event, null: false
      t.string :headline, null: false
      t.string :url

      t.timestamps
    end
  end
end
