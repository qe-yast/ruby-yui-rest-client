# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a Checkbox in UI. It can be YCheckBox.
    class Checkbox < Widgets::Base
      # Sends action to toggle the checkbox in UI (i.e. uncheck when checked, or check otherwise).
      # @example Toggle checkbox with id 'test'
      #   app.checkbox(id: 'test').toggle
      def toggle
        action(action: 'toggle')
      end

      # Sends action to explicitly check the checkbox in UI (regardless of the current state).
      # @example Check checkbox with id 'test'
      #   app.checkbox(id: 'test').check
      def check
        action(action: 'check')
      end

      # Sends action to explicitly uncheck the checkbox in UI (regardless of the current state).
      # @example Uncheck checkbox with id 'test'
      #   checkbox(id: 'test').uncheck
      def uncheck
        action(action: 'uncheck')
      end

      # Returns the state of checkbox (checked/unchecked).
      # Gets value from 'value' parameter in JSON representation of YCheckBox.
      # @return [Boolean] true if it is checked, false otherwise.
      # @example Get checkbox state
      #   {
      #     "class": "YCheckBox",
      #     "debug_label": "Change the Time Now",
      #     "id": "change_now",
      #     "label": "Chan&ge the Time Now",
      #     "notify": true,
      #     "value": true
      #   }
      # @example
      #   app.checkbox(id: 'change_now').checked? # true
      def checked?
        property(:value)
      end
    end
  end
end
