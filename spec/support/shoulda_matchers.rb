# Configure shoulda matchers https://github.com/thoughtbot/shoulda-matchers
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec

    with.library :rails
  end
end

# workaround to enable testing of serialized attributes.
# ... and avoid NoMethodError: undefined method `cast_type' for #<ActiveRecord::ConnectionAdapters::PostgreSQLColumn:0x007fd538963fb0>
# ... source: https://github.com/thoughtbot/shoulda-matchers/issues/913#issuecomment-219187051
module Shoulda
  module Matchers
    RailsShim.class_eval do
      def self.serialized_attributes_for(model)
        if defined?(::ActiveRecord::Type::Serialized)
          # Rails 5+
          model.columns.select do |column|
            model.type_for_attribute(column.name).is_a?(::ActiveRecord::Type::Serialized)
          end.inject({}) do |hash, column|
            hash[column.name.to_s] = model.type_for_attribute(column.name).coder
            hash
          end
        else
          model.serialized_attributes
        end
      end
    end
  end
end
