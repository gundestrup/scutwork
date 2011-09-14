class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.string :name
      t.integer :user_id
      t.timestamps
    end

    places('Herlev')
    places('Hvidovre')
    places('Glostrup')
    places('RH')
    places('Frederiksberg')
    places('Gentofte')
    
  end

  def self.down
    drop_table :places
  end

  def self.places(name)
    role = Place.new
    role.name = name
    role.user_id = 1
    role.save
  end
end
