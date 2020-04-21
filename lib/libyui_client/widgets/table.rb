# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a table in the UI. It can be YTable
    class Table < Widgets::Base
      # Sends action to select a row in a table.
      # @param value [String] value to select in the table.
      # @param column_id [Integer] number of column in zero-based numbering format (i.e. the first column is 0)
      # @example Select "test.item.2" in the table
      #     {
      #       "class": "YTable",
      #       "columns": 1,
      #       "id": "test_table",
      #       "items": [
      #           {
      #               "labels": [
      #                   "test.item.1"
      #               ],
      #               "selected": true
      #           },
      #           {
      #               "labels": [
      #                     "test.item.2"
      #               ]
      #           }
      #       ],
      #       "items_count": 2
      #     }
      # @example
      #   app.table(id: 'test_table').select_row(value: 'test.item.2', column_id: 0)
      def select_row(value:, column_id:)
        action(action: 'select', value: value, column: column_id)
      end
    end
  end
end
