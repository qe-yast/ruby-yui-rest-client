# frozen_string_literal: true

module LibyuiClient
  module Widget
    # Class representing a Check Box in the UI
    class Checkbox
      include Waitable

      def initialize(http_client, filter)
        @http_client = http_client
        @filter = filter
      end

      def toggle
        LibyuiClient.logger.info("Toggle the Checkbox: #{@filter}")
        @http_client.widget_send_action(@filter, action: 'toggle')
      end

      def check
        LibyuiClient.logger.info("Check the Checkbox: #{@filter}")
        @http_client.widget_send_action(@filter, action: 'check')
      end

      def uncheck
        LibyuiClient.logger.info("Uncheck the Checkbox: #{@filter}")
        @http_client.widget_send_action(@filter, action: 'uncheck')
      end

      def checked?
        LibyuiClient.logger.info("Is the Checkbox checked: #{@filter} ")
        @http_client.widget_get(@filter).body[:value]
      end
    end
  end
end
