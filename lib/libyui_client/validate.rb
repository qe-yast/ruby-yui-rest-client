# frozen_string_literal: true

module LibyuiClient
  module Validate
    module_function

    def filter(filter)
      filters = %i[id label type]
      raise ArgumentError, "Invalid filter format: #{filter.inspect}. Hash is expected." unless filter.is_a? Hash

      filter.delete_if { |_key, value| value.nil? }

      filter.each do |key, _value|
        raise ArgumentError, "Unsupported filter type is used: #{key.inspect}" unless filters.include?(key.to_sym)
      end
    end
  end
end
