require 'proffer'

require 'action_controller/railtie'
require 'rails/test_unit/railtie'

Class.new(Rails::Application) do
  config.active_support.deprecation = :stderr
end.initialize!

require 'rspec/rails'

