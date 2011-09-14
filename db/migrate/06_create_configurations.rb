class CreateConfigurations < ActiveRecord::Migration
  def self.up
    create_table :configurations do |t|
      t.boolean :sign_up
      t.boolean :login
    end
    @conf = Configuration.new
    @conf.id = 1
    @conf.sign_up = true
    @conf.login = true
    @conf.save
  end

  def self.down
    drop_table :configurations
  end
end
