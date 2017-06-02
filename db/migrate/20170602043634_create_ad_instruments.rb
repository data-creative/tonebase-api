class CreateAdInstruments < ActiveRecord::Migration[5.0]
  def change
    create_table :ad_instruments do |t|
      t.references :ad, foreign_key: true
      t.references :instrument, foreign_key: true

      t.timestamps
    end
  end
end
