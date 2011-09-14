class ChangeNormFromPlacesToUsers < ActiveRecord::Migration
  def self.up
    #Remove it from places
    remove_column :places, :normstart
    remove_column :places, :normduration

    add_column :users, :normstart, :date
    add_column :users, :norm_id, :integer
  end

  def self.down
    remove_column :users, :normstart
    remove_column :users, :norm_id

    add_column :places, :normstart, :date
    add_column :places, :normduration, :integer
  end
end
