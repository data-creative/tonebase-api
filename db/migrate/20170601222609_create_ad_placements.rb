class CreateAdPlacements < ActiveRecord::Migration[5.0]
  def change
    create_table :ad_placements do |t|
      t.references :ad, foreign_key: true
      t.date :start_date, null:false
      t.date :end_date, null:false
      t.integer :price, null:false

      t.timestamps
    end
  end
end
