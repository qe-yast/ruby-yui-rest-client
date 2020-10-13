# frozen_string_literal: true

module LibyuiClient
  class FilterExtractor
    attr_reader :full, :plain, :regex

    def initialize(filter)
      @full = build_filters(filter)
      @plain = @full.reject { |_, v| v.is_a? Regexp }
      @regex = @full.select { |_, v| v.is_a? Regexp }
    end

    def to_s
      full.to_s
    end

    private

    def build_filters(hash)
      filter = {}
      filter[:id] = hash[:id]
      # Replace '&' in label filter as search is not possible when it contains the character
      filter[:label] = hash[:label].is_a?(String) ? hash[:label].tr('&', '') : hash[:label]
      filter[:type] = hash[:class] if hash.key?(:class)
      filter.compact
    end
  end
end
