# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a numberbox in the UI. It can be YIntField.
    class Numberbox < Widgets::Base
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
      # @example
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
      # @example
      #   app.numberbox(id: 'test').max_value
      def max_value
        property(:max_value)
      end

      # Sends action to set the value of numberbox.
      # @param value [Integer] to be set in numberbox
      # @return [Numberbox] in case action is successful
      # @example Set text in numberbox with id 'test' to 123
      #   app.numberbox(id: 'test').set(123)
      def set(value)
        action(action: Actions::ENTER_TEXT, value: value)
        self
      end

      # Returns number that is currently set for numberbox.
      # Gets value from 'value' parameter in JSON representation of YIntField.
      # @return [Integer] value
      # @example Get value from numberbox with id "test"
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
      # @example
      #   app.numberbox(id: 'address').value # 3260
      def value
        property(:value)
      end
    end
  end
end
