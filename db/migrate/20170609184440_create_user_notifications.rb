class CreateUserNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :user_notifications do |t|
      t.references :user, foreign_key: true
      t.references :notification, foreign_key: true
      t.boolean :marked_read, full: false, default: false

      t.timestamps
    end

    add_index :user_notifications, [:user_id, :notification_id], unique: true
    add_index :user_notifications, :marked_read
  end
end
