# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a textbox in the UI. It can be YInputField, YPasswordField
    class Textbox < Widgets::Widget
      def initialize(widget_controller, filter)
        super(widget_controller, filter: filter, action: action, items: items)
        @action_controller = ActionController.new(widget_controller, filter: filter, action: Actions::ENTER_TEXT)
      end

      def set(value)
        @action_controller.send_action(value: value)
        self
      end



      # Returns text currently set for textbox.
      # include Behaviors::Valueable

      # include Behaviors::Settable

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
      #   app.textbox(id: 'test').max_length
      def max_length
        property(:input_max_length)
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
      #   app.textbox(id: 'test').valid_chars
      def valid_chars
        property(:valid_chars)
      end
    end
  end
end
