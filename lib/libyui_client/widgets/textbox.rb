# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a textbox in the UI. It can be YInputField.
    class Textbox < Widgets::Base
      # Returns maximum string length to set in the textbox
      # @return [Integer] maximum number of character to set in the textbox
      # @example Check maximum string length in textbox with id 'test'
      #   {
      #      "class": "YInputField",
      #      "debug_label": "label_test",
      #      "hstretch": true,
      #      "id": "test",
      #      "input_max_length": 256,
      #      "label": "label_test",
      #      "password_mode": false,
      #      "valid_chars": "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.",
      #      "value": ""
      #   }
      # @example
      #   app.textbox(id: 'test').max_length
      def max_length
        property(:input_max_length)
      end

      # Sends action to set the value of textbox.
      # @param value [String] text to be set in textbox
      # @return [Textbox] in case action is successful
      # @example Set text in textbox with id 'test' to 'my value'
      #   app.textbox(id: 'test').set('my value')
      def set(value)
        action(action: Actions::ENTER_TEXT, value: value)
        self
      end

      # Check if textbox has password mode
      # @return [Boolean] true if has password mode, otherwise false
      # @example Check password mode in textbox with id 'test'
      #   {
      #      "class": "YInputField",
      #      "debug_label": "label_test",
      #      "hstretch": true,
      #      "id": "test",
      #      "label": "label_test",
      #      "password_mode": false,
      #      "value": ""
      #   }
      # @example
      #   app.textbox(id: 'test').password?
      def password?
        property(:password_mode)
      end

      # Returns valid chars to set in the textbox
      # @return [String] containing all valid chars
      # @example Check password mode in textbox with id 'test'
      #   {
      #      "class": "YInputField",
      #      "debug_label": "label_test",
      #      "hstretch": true,
      #      "id": "test",
      #      "label": "label_test",
      #      "password_mode": false,
      #      "valid_chars": "0123456789",
      #      "value": ""
      #   }
      # @example
      #   app.textbox(id: 'test').valid_chars
      def valid_chars
        property(:valid_chars)
      end

      # Returns text that is currently set for textbox.
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
