# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a textbox in the UI. It can be YInputField.
    class Textbox < Widgets::Base
      # Sends action to set the value of textbox
      # @param value [String] text to be set in textbox
      # @example Set text in textbox with id 'test' to 'my value'
      #   app.textbox(id: 'test').set('my value')
      def set(value)
        action(action: 'enter_text', value: value)
      end

      # Returns text that is currently set for textbox
      # Gets value from 'value' parameter in JSON representation of YInputField.
      # @return [String] value
      # @example Get value from textbox with id "address"
      #   {
      #       "class": "YInputField",
      #       "debug_label": "Address",
      #       "hstretch": true,
      #       "id": "address",
      #       "label": "A&ddress",
      #       "password_mode": false,
      #       "value": "Test Address"
      #   }
      # @example
      #   app.textbox(id: 'address').value # Test Address
      def value
        property(:value)
      end
    end
  end
end
