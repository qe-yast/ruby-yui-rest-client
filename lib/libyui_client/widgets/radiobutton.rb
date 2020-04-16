# frozen_string_literal: true

module LibyuiClient
  module Widget
    # Class representing a RadioButton in the UI
    class Radiobutton
      include Waitable

      def initialize(http_client, filter)
        @http_client = http_client
        @filter = filter
      end

      def select(value)
        LibyuiClient.logger.info("Select '#{value}' in Radiobutton: #{@filter}")
        @http_client.widget_send_action(@filter, action: 'select',
                                                     value: value)
      end

      def selected?
        LibyuiClient.logger.info("Is Radiobutton selected: #{@filter}")
        @http_client.widget_get(@filter).body[:value]
      end
    end
  end
end
