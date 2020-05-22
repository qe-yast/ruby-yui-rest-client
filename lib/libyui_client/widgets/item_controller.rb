# frozen_string_literal: true

module LibyuiClient
  module Widgets
    class ItemController < Widgets::Widget
      # Returns the list of items available to select from widget.
      # @return [Array] array of Strings.
      # @example Get items from widget with id "test"
      #   {
      #     "class": "YMenuButton",
      #     "debug_label": "test",
      #     "icon_base_path": "",
      #     "id": "test",
      #     "items": [
      #       {
      #         "label": "button1"
      #       },
      #       {
      #         "label": "button2"
      #       },
      #       {
      #         "label": "button3"
      #       }
      #     ],
      #     "items_count": 3,
      #     "label": "button group"
      #   }
      # @example
      #   app.menubutton(id: 'test').items
      #   # button1
      #   # button2
      #   # button3
      def list
          property(:items).map { |x| x[:label] || x[:labels] }
      end

      def list_selected
          property(:items).map { |x| (x[:label] || x[:labels]) if x[:selected] }
      end
    end
  end
end
