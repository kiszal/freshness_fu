module FreshnessFu
  module ControllerExtensions

    # update_fresh_stuff is executed after show action by default 
    # to add/change it pass :on => [:actionX, :actionY] as an argument 

    # by default visitor is a current_user 
    # to overwrite it pass :visitor => :current_user_method_name as an argument 

    # by default object  which is updated after visitor saw stuff is 
    # object with name created from controller name 
    # ex: posts_controller => @post 
    #     groups_controller => @group 
    # to override object name pass  :object => "object_name" as an argument 

    def update_fresh_stuff(opts={})
      opts.has_key?(:on) ? actions = opts[:on] : actions = [:show]
      after_filter :only => actions do |controller, action| 
        visitor = controller.send(opts[:visitor] || :current_user)
        object_instance_name = (opts[:object] || controller.class.name.underscore.gsub!("s_controller", "").to_sym) 
        object = controller.instance_variable_get("@#{object_instance_name}")
        Visit.update_last_visit(visitor, object)
      end 
    end 

  end 
end

ActionController::Base.extend FreshnessFu::ControllerExtensions
