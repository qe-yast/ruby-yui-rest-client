# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a tab in the UI. It can be YDumbTab.
    class Tab < Widgets::Base
      # Returns the list of items available to select from tab.
      # @return [Array] array of String objects.
      # @example Get items from tab with id "test_id"
      #   {
      #     "class": "YDumbTab",
      #     "debug_label": "YDumbTab [tab1] [tab2] [tab3]",
      #     "hstretch": true,
      #     "icon_base_path": "",
      #     "id": "test_id",
      #     "items": [
      #       {
      #         "label": "tab1"
      #       },
      #       {
      #         "label": "tab2",
      #         "selected": true
      #       },
      #       {
      #         "label": "tab3"
      #       }
      #     ],
      #     "items_count": 3,
      #     "vstretch": true
      #   }
      # @example
      #   app.tab(id: 'test').items
      #   # tab1
      #   # tab2
      #   # tab3
      def items
        property(:items).map { |x| x[:label] }
      end

      # Sends action to click the tab in UI.
      # @param item [String] value to select from items.
      # @return [Tab] in case action is successful
      # @example Click tab with id 'test'
      #   app.button(id: 'test', value: test_item).select
      def select(item)
        action(action: Actions::SELECT, value: item)
        self
      end

      # Returns the label of the selected tab.
      # @return [String] label of the tab selected
      # @example Get items from tab with id "test_id"
      #   {
      #     "class": "YDumbTab",
      #     "debug_label": "YDumbTab [tab1] [tab2] [tab3]",
      #     "hstretch": true,
      #     "icon_base_path": "",
      #     "id": "test_id",
      #     "items": [
      #       {
      #         "label": "tab1"
      #       },
      #       {
      #         "label": "tab2",
      #         "selected": true
      #       },
      #       {
      #         "label": "tab3"
      #       }
      #     ],
      #     "items_count": 3,
      #     "vstretch": true
      #   }
      # @example
      #   app.tab(id: 'test').selected_item  # tab2
      def selected_item
        property(:items).select { |x| x[:selected] }.first[:label]
      end
    end
  end
end
