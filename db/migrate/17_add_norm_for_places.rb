class AddNormForPlaces < ActiveRecord::Migration
  def self.up
    add_column :places, :normstart, :date
    add_column :places, :normduration, :integer
  end

  def self.down
    remove_column :places, :normstart
    remove_column :places, :normduration
  end
end
