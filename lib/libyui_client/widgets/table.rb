# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a table in the UI. It can be YTable
    class Table < Widgets::Widget
      def initialize(widget_controller, filter)
        super(widget_controller, filter)
        @action_controller = ActionController.new(widget_controller, filter)
        @item_controller = ItemController.new(widget_controller, filter)
      end

      # Sends action to select a row in a table.
      # @param value [String] value to select in the table.
      # @param column [String] column name where value is present
      # @return [Table] in case action is successful
      # @example Select "test.item.2" in the table
      #     {
      #       "class": "YTable",
      #       "columns": 4,
      #       "header": [
      #         "header1",
      #         "header2",
      #         "header3",
      #         "header4"
      #       ],
      #       "id": "test_table",
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
      #   app.table(id: 'test_table').select_row(value: 'test.item.2', column: header1)
      def select(value:, column:)
        index = get_index(column)
        action_with_params = { action: Actions::SELECT, value: value, column: index }
        LibyuiClient.logger.info("Send action #{action_with_params} for #{class_name} #{@filter}")
        @action_controller.send_action(action_with_params)
        self
      end

      def items
        @item_controller.list
      end

      def items_selected
        @item_controller.list_selected
      end

      # Returns whether the table contains any row or not
      # @return [Boolean] true if empty, otherwise false
      # @example Check if table with id "test_table" is empty
      #    {
      #      "class": "YTable",
      #      "columns": 4,
      #      "hasMultiSelection": true,
      #      "header": [
      #        "Device",
      #        "Size",
      #        "Enc",
      #        "Type"
      #      ],
      #      "hstretch": true,
      #      "icon_base_path": "",
      #      "id": "test_table,
      #      "immediate_mode": false,
      #      "items": null,
      #      "items_count": 0,
      #      "keep_sorting": true,
      #      "notify": true,
      #      "vstretch": true
      #    }
      # @example
      #   app.table(id: 'test_table').empty?
      def empty?
        property(:items).nil?
      end

      # def items(selected_only: false)
      #   property(:items).map { |x| x[:labels] if !selected_only || x[:selected] }
      # end

      private

      def get_index(column)
        property(:header).index(column)
      end
    end
  end
end
