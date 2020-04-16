# frozen_string_literal: true

module LibyuiClient
  module Widget
    # Class representing a button in the UI
    class Button
      include Waitable

      def initialize(http_client, filter)
        @http_client = http_client
        @filter = filter
      end

      def click
        LibyuiClient.logger.info("Click Button: #{@filter}")
        @http_client.widget_send_action(@filter, action: 'press')
      end

      def debug_label
        LibyuiClient.logger.info("Get debug_label for Button: #{@filter}")
        @http_client.widget_get(@filter).body[:debug_label]
      end

      def enabled?
        LibyuiClient.logger.info("Is Button enabled: #{@filter} ")
        @http_client.widget_get(@filter).body[:enabled].nil?
      end

      def fkey
        LibyuiClient.logger.info("Get fkey for Button: #{@filter}")
        @http_client.widget_get(@filter).body[:fkey]
      end

      def exists?
        LibyuiClient.logger.info("Does Button exist: #{@filter}")
        true if @http_client.widget_get(@filter, timeout: 0)
      rescue Error::WidgetNotFoundError
        false
      end
    end
  end
end
