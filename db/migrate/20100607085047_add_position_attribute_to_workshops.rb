class AddPositionAttributeToWorkshops < ActiveRecord::Migration
  def self.up
    add_column :workshops, :position, :integer, :default => 0
  end

  def self.down
    remove_column :workshops, :position
  end
end
