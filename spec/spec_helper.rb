require 'rubygems'
require 'active_record'
require 'action_controller'
require 'spec'
require 'ruby-debug'

TEST_DATABASE_FILE = File.join(File.dirname(__FILE__), '..', 'test.sqlite3')
File.unlink(TEST_DATABASE_FILE) if File.exist?(TEST_DATABASE_FILE)
 
ActiveRecord::Base.establish_connection("adapter" => "sqlite3", "database" => TEST_DATABASE_FILE)
 
load(File.dirname(__FILE__) + '/schema.rb')
 
%w[active_record_extensions controller_extensions visit].each do |item|
  require File.join(File.dirname(__FILE__), '..', 'lib', 'freshness_fu', item)
end
 
class PostsController <  ActionController::Base
end
 
class User < ActiveRecord::Base
end

class Comment < ActiveRecord::Base
  belongs_to :post
end 
  
class Photo < ActiveRecord::Base 
  belongs_to :post
end

class Post < ActiveRecord::Base
  has_many :comments
  has_many :photos
  track_fresh_stuff :what => [:comments, :photos] 
end
 
class FooModel < ActiveRecord::Base
end

Spec::Runner.configure do |config|
  def current_user(name = {})
    @current_user ||= User.create(:name => 'tester')
  end
end


