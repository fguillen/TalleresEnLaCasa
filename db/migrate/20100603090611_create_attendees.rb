class CreateAttendees < ActiveRecord::Migration
  def self.up
    create_table :attendees do |t|
      t.string :name
      t.string :email
      t.text :comment
      t.string :phone
      t.integer :workshop_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :attendees
  end
end
