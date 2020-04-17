# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a Check Box in the UI
    class Checkbox < Widgets::Base
      def toggle
        action(action: 'toggle')
      end

      def check
        action(action: 'check')
      end

      def uncheck
        action(action: 'uncheck')
      end

      def checked?
        property(:value)
      end
    end
  end
end
