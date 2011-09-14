class LanguageToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :language_id, :integer, :default => 1
    
  end

  def self.down
    remove_column :users, :language_id
  end
end
