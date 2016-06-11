class AddForeignKeyToEvents < ActiveRecord::Migration[5.0]
  def change
  	rename_column :events, :host, :host_id
  	add_foreign_key :events, :users, column: :host_id
  end
end
