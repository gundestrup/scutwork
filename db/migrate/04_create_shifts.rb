class CreateShifts < ActiveRecord::Migration
  def self.up
    create_table :shifts do |t|
      t.timestamp :start
      t.timestamp :end
      t.integer :place_id
      t.integer :user_id
      t.boolean :active, :default => '1'

      t.timestamps
    end
  end

  def self.down
    drop_table :shifts
  end
end
