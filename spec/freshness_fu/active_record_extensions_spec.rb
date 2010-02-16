require File.dirname(__FILE__) + '/../spec_helper'

describe "FreshnessFu ActiveRecordExtensions" do
  
  describe "Relevant methods should be added" do 

    before(:each) do 
      @post = Post.create(:title => 'Holidays')
      @post.comments.create(:title => 'I love Spain') 
      @post.comments.create(:title => 'I love France') 
      @post.photos.create(:title => 'Nice ocean view')
    end
    
    it "comment object should have flag methods" do 
      @post.comments.first.should respond_to(:fresh)      
      @post.comments.first.should respond_to(:fresh!)      
      @post.comments.first.should respond_to(:fresh?)      
    end 

    it "photo object should have flag methods" do 
      @post.photos.first.should respond_to(:fresh)      
      @post.photos.first.should respond_to(:fresh!)      
      @post.photos.first.should respond_to(:fresh?)     
    end 
    
    it "post should have method photos_with_fresh_stuff" do
      @post.should respond_to(:photos_with_fresh_stuff) 
    end

    it "post should have method comments_with_fresh_stuff" do
      @post.should respond_to(:comments_with_fresh_stuff) 
    end
    
  end 

  describe "User sees stuff for the first time" do 
    before(:each) do 
      @post = Post.create(:title => 'Holidays')
      @post.comments.create(:title => 'I love Spain') 
      @post.comments.create(:title => 'I love France') 
      @post.photos.create(:title => 'Nice ocean view')
    end
    
    it "all comments in post should be fresh for current user" do 
      @post.comments_with_fresh_stuff(current_user).each do |c|
        c.fresh?.should be_true
      end 
    end

    it "all photos in post should be fresh for current user" do 
      @post.photos_with_fresh_stuff(current_user).each do |p|
        p.fresh?.should be_true
      end 
    end
  end 

  describe "User sees stuff for the first time" do 
    before(:each) do 
      @post = Post.create(:title => 'Holidays')
      @post.comments.create(:title => 'I love Spain') 
      @post.comments.create(:title => 'I love France') 
      @post.photos.create(:title => 'Nice ocean view')
      Visit.update_last_visit(current_user,@post)
      Visit.first.update_attributes(:last_visit => Time.now + 1.minute) 
    end
    
    it "all comments in post should be fresh for current user" do 
      @post.comments_with_fresh_stuff(current_user).each do |c|
        c.fresh?.should_not be_true
      end 
    end

    it "all photos in post should be fresh for current user" do 
      @post.photos_with_fresh_stuff(current_user).each do |p|
        p.fresh?.should_not be_true
      end 
    end
  end 


  describe "track_fresh_stuff options" do 
    it ":what is mandatory" do 
      lambda {FooModel.track_fresh_stuff} .should raise_error(ArgumentError)
    end 
  end 

end
