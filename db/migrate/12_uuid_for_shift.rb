require 'uuid'
class UuidForShift < ActiveRecord::Migration

  def self.up
    add_column :shifts, :uuid, :string, :null => false
    for shift in Shift.find(:all)
      shift.uuid = srand
      shift.save
    end
  end


  def self.down
    remove_column :shifts, :uuid
  end


end
