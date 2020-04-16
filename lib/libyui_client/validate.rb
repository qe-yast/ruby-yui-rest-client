# frozen_string_literal: true

module LibyuiClient
  module Filter
    module_function

    FILTERS = %i[id label type].freeze

    def validate(filter)
      raise ArgumentError, "invalid filter format: #{filter.inspect}. Hash is expected (e.g. find(id: \"some_id\"))." unless filter.is_a? Hash

      filter.each_key { |key| raise ArgumentError, "unsupported filter type is used: #{key.inspect}" unless FILTERS.include?(key.to_sym) }

      filter
    end
  end
end