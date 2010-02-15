class Visit < ActiveRecord::Base
  set_table_name 'freshness_fu_visits'

  belongs_to :visitor, :polymorphic => true

  def self.last_visit(persona, object)
    return  persona.object_visits.find_by_object_type_and_object_id(object.class.name, object.id).try(:last_visit) 
  end
  
  def self.update_last_visit(persona,object)
    
    visit = persona.object_visits.find_by_object_type_and_object_id(object.class.name, object.id)
    
    if visit   
      visit = persona.object_visits.find_by_object_type_and_object_id(object.class.name, object.id)
      visit.update_attributes(:last_visit => Time.now)
    else 
      Visit.create(:object_type => object.class.name, :object_id => object.id, 
                   :visitor_type  => persona.class.name, :visitor_id => persona.id, 
                   :last_visit => Time.now)
    end 
  end 
end
