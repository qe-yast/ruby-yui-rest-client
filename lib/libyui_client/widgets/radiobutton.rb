# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a RadioButton in the UI. It can be YRadioButton.
    class Radiobutton < Widgets::Base
      # Sends action to select the radiobutton in UI.
      # @return [Radiobutton] in case action is successful
      # @example Select radiobutton with id 'test'
      #   app.radiobutton(id: 'test').select
      def select
        action(action: Actions::SELECT)
        self
      end

      # Returns the state of radiobutton (selected or not).
      # Gets value from 'value' parameter in JSON representation of YRadioButton.
      # @return [Boolean] true if the radiobutton is selected, false otherwise.
      # @example Get state for radiobutton with id "manual"
      #   {
      #     "class": "YRadioButton",
      #     "debug_label": "Manually",
      #     "id": "manual",
      #     "label": "&Manually",
      #     "notify": true,
      #     "value": false
      #   }
      # @example
      #   app.radiobutton(id: 'manual').selected? # false
      def selected?
        property(:value)
      end
    end
  end
end
