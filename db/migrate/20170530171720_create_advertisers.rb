class CreateAdvertisers < ActiveRecord::Migration[5.0]
  def change
    create_table :advertisers do |t|
      t.string :name, null: false
      t.text :description
      t.string :url
      t.text :metadata

      t.timestamps
    end

    add_index :advertisers, :name, unique: true
  end
end
