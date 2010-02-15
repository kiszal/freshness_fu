class FreshnessFuGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template "create_freshness_fu_visits.rb", "db/migrate", :migration_file_name => 'create_freshness_fu_visits'
    end
  end
end
