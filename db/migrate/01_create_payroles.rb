class CreatePayroles < ActiveRecord::Migration
  def self.up
    create_table :payroles do |t|
      t.integer :shift_id
      t.integer :pay_id
      t.integer :hours
      
      t.timestamps
    end
  end

  def self.down
    drop_table :payroles
  end
end
