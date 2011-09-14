require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  
  test "validates_presence_of :name, :description" do
    #only name
    language = Language.new
    language.name = "name"
    assert !language.save, "Saved the language without name"
    #only description
    language.name = nil
    language.description = "description"
    assert !language.save, "Saved the language without description"
    #name and description working
    language.name = "name"
    assert language.save, "Saved the language with description and name"
  end
  
  test "validates_uniqueness_of :name, :description, :case_sensitive => false" do
    # the basics
    language = Language.new
    language.name = "en"
    language.description = "description"
    language.save
    #test of name not unique
    language = Language.new
    language.name = "en"
    language.description = "description2"
    assert !language.save, "Saved the language not unique name"
    #test of description, not unique
    language = Language.new
    language.name = "en2"
    language.description = "description"
    assert language.save, "Saved the language not unique description"
    
    #now with case sensitive
    #test of name
    language = Language.new
    language.name = "En"
    language.description = "description2"
    assert !language.save, "Saved the language not unique name"
    #test of description
    language = Language.new
    language.name = "en2"
    language.description = "Description"
    assert !language.save, "Saved the language not unique description"
    
    #the true save
    language = Language.new
    language.name = "new language"
    language.description = "new escription"
    assert language.save, "Saved the language with unique description and name"
  end
  
end
