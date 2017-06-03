class CreateUserFollows < ActiveRecord::Migration[5.0]
  def change
    create_table :user_follows do |t|
      t.references :user, foreign_key: true
      t.integer :follower_id # can't use :foreign_key here, so add below ...

      t.timestamps
    end

    add_foreign_key :user_follows, :users, column: :follower_id
    #add_index :user_follows, [:user_id, :follower_id], :unique => true
  end
end
