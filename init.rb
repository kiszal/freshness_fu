%w[active_record_extensions controller_extensions visit].each do |item|
  require File.join(File.dirname(__FILE__), 'lib', 'freshness_fu', item)
end
