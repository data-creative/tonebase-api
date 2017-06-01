class CreateAds < ActiveRecord::Migration[5.0]
  def change
    create_table :ads do |t|
      t.references :advertiser, foreign_key: true
      t.string :title, null: false
      t.text :content
      t.string :url
      t.string :image_url

      t.timestamps
    end
  end
end
