# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a button in the UI
    class Button < Widgets::Base
      def click
        action(action: 'press')
      end

      def fkey
        property(:fkey)
      end
    end
  end
end
