class PlacesToUsers < ActiveRecord::Migration
  def self.up
    #Removed current places
    Place.delete_all
    #Removed created shifts
    Shift.delete_all
    #Added new colume
    columns = Configuration.columns_hash
    
    if 1==2#columns[user_id].present? 
      add_column :places, :user_id, :integer
    end

  end
  

  def self.down
    remove_column :places, :user_id    
  end
end
