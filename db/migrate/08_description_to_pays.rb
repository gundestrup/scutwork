class DescriptionToPays < ActiveRecord::Migration
  def self.up
    add_column :pays, :description, :text
  end

  def self.down
    remove_column :pays, :description
  end
end
