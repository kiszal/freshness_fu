class CreateFreshnessFuVisits < ActiveRecord::Migration
  def self.up
    create_table :freshness_fu_visits do |t|
      t.string     :visitor_type, :object_type
      t.integer    :visitor_id, :object_id 
      t.datetime   :last_visit
      t.timestamps
    end
  end

  def self.down
    drop_table :freshness_fu_visits
  end
end
