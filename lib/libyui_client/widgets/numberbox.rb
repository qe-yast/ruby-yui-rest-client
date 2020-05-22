# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a textbox in the UI. It can be YInputField.
    class Numberbox < Widgets::Widget
      # Returns text currently set for textbox.
      # include Behaviors::Valueable

      # include Behaviors::Settable

      # Returns minimum value to set in the numberbox
      # @return [Integer] with minimum value
      # @example Get minimum value to set numberbox with id 'test'
      #   {
      #      "class": "YIntField",
      #      "debug_label": "label_test",
      #      "hstretch": true,
      #      "id": "test",
      #      "label": "label_test",
      #      "max_value": 65535,
      #      "min_value": 0,
      #      "value": 3260
      #   }
      #   app.numberbox(id: 'test').min_value
      def min_value
        property(:min_value)
      end

      # Returns maximum value to set in the numberbox
      # @return [Integer] with maximum value
      # @example Get maximum value to set numberbox with id 'test'
      #   {
      #      "class": "YIntField",
      #      "debug_label": "label_test",
      #      "hstretch": true,
      #      "id": "test",
      #      "label": "label_test",
      #      "max_value": 65535,
      #      "min_value": 0,
      #      "value": 3260
      #   }
      #   app.numberbox(id: 'test').max_value
      def max_value
        property(:max_value)
      end
    end
  end
end
