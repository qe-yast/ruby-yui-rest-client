# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a RadioButton in the UI
    class Radiobutton < Widgets::Base
      def select
        action(action: 'select')
      end

      def selected?
        property(:value)
      end
    end
  end
end
