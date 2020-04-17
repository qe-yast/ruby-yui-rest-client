# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a textbox in the UI
    class Textbox < Widgets::Base
      def set(value)
        action(action: 'enter_text', value: value)
      end

      def value
        property(:value)
      end
    end
  end
end
