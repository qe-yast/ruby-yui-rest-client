# frozen_string_literal: true

module YuiRestClient
  module Widgets
    # Class representing a menucollection in UI. It can be YMenuButton, YMenuBar.
    class Menucollection < Widgets::Base
      # Sends action to click one item of a menu (menu button or menu bar) in UI.
      # @param path [String] value to select from menu.
      # @example Click menu item with label 'sub_menu_item' for menucollection
      # with id 'test_id'.
      # @example
      #   app.menucollection(id: 'test_id').click('menu_item|sub_menu_item')
      def click(path)
        action(action: Actions::SELECT, value: path)
      end

      # Returns the list of items available to select from widget.
      # @return [Array<String>] array of strings.
      # @example Get items from widget with id "test_id"
      #   {
      #     "class": "YMenuButton",
      #     "debug_label": "test",
      #     "icon_base_path": "",
      #     "id": "test_id",
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
      #   app.menucollection(id: 'test').items
      #   # button1
      #   # button2
      #   # button3
      def items
        property(:items).map { |x| x[:label] }
      end
    end
  end
end
