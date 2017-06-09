class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :broadcastable, polymorphic: true, null: false
      t.string :event, null: false
      t.string :headline, null: false
      t.string :url

      t.timestamps
    end

    add_index :notifications, [:event, :broadcastable_id, :broadcastable_type], unique: true, name: "index_notifications_on_composite_key"
  end
end
