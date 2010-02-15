module FreshnessFu
  module ActiveRecordExtensions

    module Markers
      attr_accessor :fresh
      def fresh!
        self.fresh = true 
      end
      def fresh?
        self.fresh == true
      end 
    end   
    
    # mandatory 
    #   :what - relations 
    # not mandatory 
    #   :visitor_model - default User

    def track_fresh_stuff(opts={})
      raise ArgumentError, "Argument :what is mandatory" unless opts.has_key?(:what)
   
      opts.has_key?(:visitor_model) ? visitor_model = opts[:visitor_model].constantize : visitor_model = User
       
      visitor_model.class_eval do
        has_many :object_visits, :class_name => 'Visit', :foreign_key => :visitor_id, :as => :visitor
      end 

      tracked_relations = [opts[:what]].flatten
      tracked_relations.each do |relation| 
        #class name can be different that relation name has_many => :people , :class_name => 'Foo' 
        reflections[relation].klass.class_eval do 
          include Markers
        end
  
        define_method("#{relation}_with_fresh_stuff") do |*args|
          visitor = *args
          last_visit = Visit.last_visit(visitor, self)
          send(relation).collect do |item| 
            item.fresh! if last_visit.nil? or item.created_at > last_visit 
            item
          end 
        end

      end 
    end 
  end 
end


ActiveRecord::Base.extend FreshnessFu::ActiveRecordExtensions
