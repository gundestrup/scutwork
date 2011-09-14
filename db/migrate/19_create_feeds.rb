class CreateFeeds < ActiveRecord::Migration
  def self.up
    create_table :feeds do |t|
      t.integer :user_id
      t.date :expire
      t.string :name
      t.string :access_code

      t.timestamps
    end
  end

  def self.down
    drop_table :feeds
  end
end
