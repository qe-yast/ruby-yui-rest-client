# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a menubutton in UI. It can be YMenuButton.
    class Menubutton < Widgets::Base
      # Sends action to click on one of the items of the menubutton in UI.
      # @param item [String] value to select from items.
      # @example Click button with label 'test_button' for menubutton with id 'test_id'.
      # @example
      #   app.menubutton(id: 'test_id').click('test_button')
      def click(item)
        action(action: Actions::PRESS, value: item)
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
      #   app.menubutton(id: 'test').items
      #   # button1
      #   # button2
      #   # button3
      def items
        property(:items).map { |x| x[:label] }
      end
    end
  end
end
