class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :date
      t.string :location
      t.integer :host

      t.timestamps
    end
    add_index :events, [:host, :created_at]
  end
end
