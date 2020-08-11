# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a table in the UI. It can be YTable
    class Table < Widgets::Base
      # Returns whether the table contains any row or not
      # @return [Boolean] true if table is empty, otherwise false
      # @example Check if table with id "test_id" is empty
      #     {
      #       "class": "YTable",
      #       "columns": 4,
      #       "header": [
      #         "header1",
      #         "header2",
      #         "header3",
      #         "header4"
      #       ],
      #       "id": "test_id",
      #       "items": null,
      #       "items_count": 0
      #     }
      # @example
      #   app.table(id: 'test_id').empty?
      def empty?
        property(:items).nil?
      end

      # Returns the list of items available to select from the table.
      # @return [Array] array of [Array] objects containing values for each column
      # @example Get items from the table with id "test_id"
      #     {
      #       "class": "YTable",
      #       "columns": 4,
      #       "header": [
      #         "header1",
      #         "header2",
      #         "header3",
      #         "header4"
      #       ],
      #       "id": "test_id",
      #       "items": [
      #           {
      #               "labels": [
      #                   "test.item.1",
      #                   "",
      #                   "",
      #                   ""
      #               ],
      #               "selected": true
      #           },
      #           {
      #               "labels": [
      #                   "test.item.2",
      #                   "",
      #                   "",
      #                   ""
      #               ]
      #           }
      #       ],
      #       "items_count": 2
      #     }
      # @example
      #   app.table(id: 'test_id').items
      #   # [test.item.1, "", "", ""]
      #   # [test.item.2, "", "", ""]
      def items
        property(:items).map { |x| x[:labels] }
      end

      # Returns the list of column names.
      # @return [Array] array of [String] objects containing names of the columns
      # @example Get header column names from the table with id "test_id"
      #   app.table(id: 'test_id').header
      def header
        property(:header)
      end

      # Sends action to select a row in a table. Row can be selected either by
      # cell value in the column (first column will be used by default), or by
      # row number directly. If both are provided, value will be used.
      # NOTE: row number corresponds to the position of the
      # item in the list of column values which might differ to the display order.
      # @param value [String] value to select in the table.
      # @param column [String] column name where value is present
      # @param row [Numeric] row number to select in the table.
      # @return [Table] in case action is successful
      # @example Select row with value "test.item.2" for column "header1" in table with id 'test_id'
      #   app.table(id: 'test_id').select(value: 'test.item.2', column: 'header1')
      # @example Select row number 3 in table with id 'test_id'
      #   app.table(id: 'test_id').select(row: 3)
      def select(value: nil, column: nil, row: nil)
        params = { action: Actions::SELECT }
        if !value.nil?
          params.merge!(value: value)
          params.merge!(column: get_index(column)) unless column.nil?
        elsif !row.nil?
          params.merge!(row: row)
        end
        action(params)
        self
      end

      # Returns the list of items currently selected from the table.
      # @return [Array] array of [Array] objects containing values for each column
      # @example Get items from the table with id "test_id"
      #     {
      #       "class": "YTable",
      #       "columns": 4,
      #       "header": [
      #         "header1",
      #         "header2",
      #         "header3",
      #         "header4"
      #       ],
      #       "id": "test_id",
      #       "items": [
      #           {
      #               "labels": [
      #                   "test.item.1",
      #                   "",
      #                   "",
      #                   ""
      #               ],
      #               "selected": true
      #           },
      #           {
      #               "labels": [
      #                   "test.item.2",
      #                   "",
      #                   "",
      #                   ""
      #               ],
      #               "selected": true
      #           }
      #       ],
      #       "items_count": 2
      #     }
      # @example
      #   app.table(id: 'test_id').selected_items
      #   # [test.item.1, "", "", ""]
      #   # [test.item.2, "", "", ""]
      def selected_items
        property(:items).map { |x| x[:labels] if x[:selected] }.compact
      end

      private

      def get_index(column)
        header.index(column)
      end
    end
  end
end
