# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a selectionbox in the UI. It can be YSelectionBox.
    class Selectionbox < Widgets::Base
      # Returns the list of items available to select from selection box.
      # @return [Array] array of String objects.
      # @example Get items from selection box with id "test_id"
      #   {
      #     "class" : "YSelectionBox",
      #     "debug_label" : "selection box title",
      #     "hstretch" : true,
      #     "icon_base_path" : "",
      #     "id" : "test_id",
      #     "items" :
      #     [
      #       {
      #         "label" : "selection 1",
      #         "selected" : true
      #       },
      #       {
      #         "label" : "selection 2"
      #       },
      #       {
      #         "label" : "selection 3"
      #       }
      #     ],
      #     "items_count" : 3,
      #     "label" : "&selection box title",
      #     "vstretch" : true
      #   }
      #
      # @example
      #   app.selectionbox(id: 'test_id').items
      #   # selection 1
      #   # selection 2
      #   # selection 3
      def items
        property(:items).map { |x| x[:label] }
      end

      # Sends action to click the selection in UI.
      # @param item [String] value to select from items.
      # @return [Selectionbox] in case action is successful
      # @example Click selection with id 'test_id'
      #   app.selectionbox(id: 'test_id').select('item_id')
      def select(item)
        action(action: Actions::SELECT, value: item)
        self
      end

      # Returns selected item in selection box.
      # @example Get selected item in selection box with id "test_id"
      #   {
      #     "class" : "YSelectionBox",
      #     "debug_label" : "selection box title",
      #     "hstretch" : true,
      #     "icon_base_path" : "",
      #     "id" : "test_id",
      #     "items" :
      #     [
      #       {
      #         "label" : "selection 1",
      #         "selected" : true
      #       },
      #       {
      #         "label" : "selection 2"
      #       },
      #       {
      #         "label" : "selection 3"
      #       }
      #     ],
      #     "items_count" : 3,
      #     "label" : "&selection box title",
      #     "vstretch" : true
      #   }
      #
      # @example
      #   app.selectionbox(id: 'test_id').selected_item
      #   # selection 1
      def selected_item
        property(:items).select { |x| x[:selected] }.first[:label]
      end
    end
  end
end
