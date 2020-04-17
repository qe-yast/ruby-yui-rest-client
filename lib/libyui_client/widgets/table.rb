# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a table in the UI
    class Table < Widgets::Base
      def select_row(value:, column_id:)
        action(action: 'select', value: value, column: column_id)
      end
    end
  end
end
