class CreateUserFollowships < ActiveRecord::Migration[5.0]
  def change
    create_table :user_followships do |t|
      t.references :user, foreign_key: true
      t.references :followed_user, index: true # requires foreign key addition, below...

      t.timestamps
    end

    add_foreign_key :user_followships, :users, column: :followed_user_id
    add_index :user_followships, [:user_id, :followed_user_id], unique: true
  end
end
