class CreateMolds < ActiveRecord::Migration
  def self.up
    create_table :molds do |t|
      t.string :name
      t.time :start_time
      t.time :end_time
      t.integer :user_id
      t.integer :place_id
      t.integer :pay_id
      t.integer :hours

      t.timestamps
    end
  end

  def self.down
    drop_table :molds
  end
end
