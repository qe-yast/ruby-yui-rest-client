# frozen_string_literal: true

module LibyuiClient
  module Widget
    # Class representing a ComboBox in the UI
    class Combobox
      include Waitable

      def initialize(http_client, filter)
        @http_client = http_client
        @filter = filter
      end

      def select(value)
        LibyuiClient.logger.info("Select '#{value}' in Combobox: #{@filter}")
        @http_client.widget_send_action(@filter, action: 'select',
                                                     value: value)
      end

      def items
        LibyuiClient.logger.info("Get all labels in Combobox: #{@filter}")
        @http_client.widget_get(@filter)[:items].map(&:label)
      end

      def selected_item
        LibyuiClient.logger.info("Get selected item in Combobox: #{@filter}")
        @http_client.widget_get(@filter).body[:value]
      end

      def exists?
        LibyuiClient.logger.info("Does the Button exist: #{@filter}")
        true if @http_client.widget_get(@filter, timeout: 0)
      rescue Error::WidgetNotFoundError
        false
      end
    end
  end
end
