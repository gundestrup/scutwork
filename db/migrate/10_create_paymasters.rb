class CreatePaymasters < ActiveRecord::Migration
  def self.up
    create_table :paymasters do |t|
      t.integer :mold_id
      t.integer :pay_id
      t.integer :hours

      t.timestamps
    end
    remove_column :molds, :pay_id
    remove_column :molds, :hours
  end

  def self.down
    drop_table :paymasters

    add_column :molds, :pay_id, :integer
    add_column :molds, :hours, :integer
  end
end
