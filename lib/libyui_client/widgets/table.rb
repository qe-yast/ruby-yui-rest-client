# frozen_string_literal: true

module LibyuiClient
  module Widget
    # Class representing a table in the UI
    class Table
      include Waitable

      def initialize(http_client, filter)
        @http_client = http_client
        @filter = filter
      end

      def select_row(value:, column:)
        LibyuiClient.logger.info("Select '#{value}' in Table: #{@filter}")
        @http_client.widget_send_action(@filter, action: 'select',
                                                     value: value,
                                                     column: column)
      end
    end
  end
end
