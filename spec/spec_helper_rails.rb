require 'proffer'

require 'action_controller/railtie'
require 'rails/test_unit/railtie'

class TestApplication < Rails::Application
  config.active_support.deprecation = :stderr
end
TestApplication.initialize!

require 'rspec/rails'

