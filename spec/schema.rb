ActiveRecord::Schema.define :version => 0 do

  create_table :freshness_fu_visits do |t|
    t.string     :visitor_type, :object_type
    t.integer    :visitor_id, :object_id 
    t.datetime   :last_visit
    t.timestamps
  end

  create_table "users", :force => true do |t|
    t.string "name"
    t.timestamps
  end 
  
  create_table "posts", :force => true do |t|
    t.string "title"
  end 
  
  create_table "comments", :force => true do |t|
    t.string  "title"
    t.integer "post_id"
    t.timestamps
  end 
  
  create_table "photos", :force => true do |t|
    t.string  "title"
    t.integer "post_id"
    t.timestamps
  end 

  create_table :foo_models, :force => true do |t|
  end 
  
end
