require 'test_helper'

class FeedTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  #  validates_presence_of :name, :expire, :user_id
  test "validates_presence_of name" do
    feed = Feed.new
    feed.expire = Time.now
    feed.user_id = 1
    assert !feed.save, "Saved the feed without a title"
  end
  
  test "validates_presence_of expire" do
    feed = Feed.new
    feed.name = "name"
    feed.user_id = 1
    assert !feed.save, "Saved the feed without expire"
    
  end
  
  test "validates_presence_of user_id" do
    feed = Feed.new
    feed.expire = Time.now
    feed.name = "name"
    assert !feed.save, "Saved the feed without a user_id"    
  end

  test "valid save with name, expire and user_id" do
    feed = Feed.new
    feed.expire = Time.now
    feed.name = "name"
    feed.user_id = 1
    assert feed.save, "Saved the feed with user_id, expire, name"    
  end
  
end
