# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a ComboBox in the UI
    class Combobox < Widgets::Base
      def select(value)
        action(action: 'select', value: value)
      end

      def items
        property(:items).map { |x| x[:label] }
      end

      def selected_item
        property(:value)
      end
    end
  end
end
