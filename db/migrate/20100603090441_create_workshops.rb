class CreateWorkshops < ActiveRecord::Migration
  def self.up
    create_table :workshops do |t|
      t.string :title
      t.text :description
      t.text :short_description
      t.string :permalink
      t.timestamps
    end
  end
  
  def self.down
    drop_table :workshops
  end
end
