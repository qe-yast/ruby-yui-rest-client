# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a Checkbox in UI. It can be YCheckBox.
    class Checkbox < Widgets::Widget
      # Returns the state of checkbox (checked/unchecked).
      # include Behaviors::Valueable

      # Sends action to toggle the checkbox in UI (i.e. uncheck when checked, or check otherwise).
      # @return [Checkbox] in case action is successful
      # @example Toggle checkbox with id 'test'
      #   app.checkbox(id: 'test').toggle
      def toggle
        action(action: Actions::TOGGLE)
        self
      end

      # Sends action to explicitly check the checkbox in UI (regardless of the current state).
      # @return [Checkbox] in case action is successful
      # @example Check checkbox with id 'test'
      #   app.checkbox(id: 'test').check
      def check
        action(action: Actions::CHECK)
        self
      end

      # Sends action to explicitly uncheck the checkbox in UI (regardless of the current state).
      # @return [Checkbox] in case action is successful
      # @example Uncheck checkbox with id 'test'
      #   checkbox(id: 'test').uncheck
      def uncheck
        action(action: Actions::UNCHECK)
        self
      end
    end
  end
end
