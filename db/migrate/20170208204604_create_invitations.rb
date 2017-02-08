class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.integer :invitee_id, index: true
      t.integer :event_id, index: true
      t.string :rsvp

      t.timestamps
    end
    add_foreign_key :invitations, :users, column_name: :invitee_id
  end
end
