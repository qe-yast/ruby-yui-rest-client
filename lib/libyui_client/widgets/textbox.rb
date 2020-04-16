# frozen_string_literal: true

module LibyuiClient
  module Widget
    # Class representing a textbox in the UI
    class Textbox
      include Waitable

      def initialize(http_client, filter)
        @http_client = http_client
        @filter = filter
      end

      # rubocop: disable Naming/AccessorMethodName
      def set_text(value)
        LibyuiClient.logger.info("Set text '#{value}' in Textbox: #{@filter}")
        @http_client.widget_send_action(@filter, action: 'enter_text',
                                                     value: value)
      end
      # rubocop: enable Naming/AccessorMethodName

      def value
        LibyuiClient.logger.info("Get value from Textbox: #{@filter}")
        @http_client.widget_get(@filter).body[:value]
      end

      def password_mode?
        LibyuiClient.logger.info("Is Textbox has password mode: #{@filter}")
        @http_client.widget_get(@filter).body[:password_mode]
      end
    end
  end
end
