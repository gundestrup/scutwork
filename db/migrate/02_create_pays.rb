class CreatePays < ActiveRecord::Migration
  def self.up
    create_table :pays do |t|
      t.integer :user_id
      t.date :start_date, :default => Time.now
      t.date :end_date
      t.boolean :active, :default => '1'
      t.string :name
      t.integer :rate

      t.timestamps
    end
  end

  def self.down
    drop_table :pays
  end
end
