class CreateInstruments < ActiveRecord::Migration[5.0]
  def change
    create_table :instruments do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end

    add_index :instruments, :name, unique: true
  end
end
