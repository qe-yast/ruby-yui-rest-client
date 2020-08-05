# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a ComboBox in the UI. It can be YComboBox.
    class Combobox < Widgets::Base
      # Returns the list of items available to select from combobox.
      # @return [Array<String>] array of strings.
      # @example Get items from combobox with id "nfs_version"
      #   {
      #     "class": "YComboBox",
      #     "debug_label": "NFS Version",
      #     "icon_base_path": "",
      #     "id": "nfs_version",
      #     "items": [
      #       {
      #         "label": "Any (Highest Available)",
      #         "selected": true
      #       },
      #       {
      #         "label": "Force NFSv3"
      #       }
      #     ],
      #     "items_count": 5,
      #     "label": "NFS &Version",
      #     "value": "Any (Highest Available)"
      #   }
      # @example
      #   app.combobox(id: 'nfs_version').items
      #   # Any (Highest Available)
      #   # Force NFSv3
      def items
        property(:items).map { |x| x[:label] }
      end

      # Sends action to select the item in combobox.
      # @param item [String] item to select in combobox.
      # List of items can be retrieved from JSON "items"->"label" manually or by using 'combobox(filter).items'.
      # @return [Combobox] in case action is successful
      # @raise LibyuiClient::Error::ItemNotFoundInWidgetError in case value is not found in combobox.
      # @example Select "Force NFSv3" item in combobox with id "nfs_version"
      #   app.combobox(id: 'nfs_version').select('Force NFSv3')
      def select(item)
        action(action: Actions::SELECT, value: item)
        self
      end

      # Returns selected item in combobox.
      # @example Get selected item in combobox with id "nfs_version"
      #   {
      #     "class": "YComboBox",
      #     "debug_label": "NFS Version",
      #     "icon_base_path": "",
      #     "id": "nfs_version",
      #     "items": [
      #       {
      #         "label": "Any (Highest Available)",
      #         "selected": true
      #       },
      #       {
      #         "label": "Force NFSv3"
      #       }
      #     ],
      #     "items_count": 5,
      #     "label": "NFS &Version",
      #     "value": "Any (Highest Available)"
      #   }
      # @example
      #   app.combobox(id: 'nfs_version').value
      def value
        property(:value)
      end

      # Sends action to set string to the editable combobox.
      # @param item [String] value to set in the combobox.
      # To check if combobox is editable, call editable?
      # @return [Combobox] in case action is successful
      # @raise LibyuiClient::Error::ItemNotFoundInWidgetError in case value is not found in combobox.
      # @example Set "Custom Version" item in combobox with id "nfs_version"
      #   app.combobox(id: 'nfs_version').select('Custom Version')
      def set(value)
        action(action: Actions::ENTER_TEXT, value: value)
        self
      end

      # Allows to check if combobox is editable and allows setting .
      # @return [Boolean] true if widget enabled, false otherwise.
      # @example Check if combobox with id 'test' editable
      #   app.combobox(id: 'test').editable? # true
      def editable?
        property(:editable) == true
      end
    end
  end
end
