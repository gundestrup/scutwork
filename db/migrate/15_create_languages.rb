class CreateLanguages < ActiveRecord::Migration
  def self.up
    create_table :languages do |t|
      t.string :name
      t.text :description

      t.timestamps

    end
    lang("en", "English", 1)
    lang("da", "Dansk", 2)
  end

  def self.down
    drop_table :languages
  end
  
  def self.lang(name,description, id)
    lang = Language.new
    lang.id = id
    lang.name = name
    lang.description = description
    lang.save
  end
end
