# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a RadioButton in the UI. It can be YRadioButton.
    class Radiobutton < Widgets::Widget
      # Returns the state of radiobutton (selected or not).
      # include Behaviors::Valueable

      # Sends action to select the radiobutton in UI.
      # @return [Radiobutton] in case action is successful
      # @example Select radiobutton with id 'test'
      #   app.radiobutton(id: 'test').select
      def click
        action(action: Actions::SELECT)
        self
      end
    end
  end
end
