# frozen_string_literal: true

module LibyuiClient
  module Widgets
    class Base
      include Waitable

      def initialize(http_client, filter)
        @http_client = http_client
        @filter = filter
      end

      def exists?
        LibyuiClient.logger.info("Does #{class_name} exist: #{@filter}")
        true if @http_client.widget_get(@filter, timeout: 0)
      rescue Error::WidgetNotFoundError
        false
      end

      def enabled?
        enabled_prop = property(:enabled)
        enabled_prop.nil? || enabled_prop == true
      end

      def debug_label
        property(:debug_label)
      end

      def property(property)
        LibyuiClient.logger.info("Get #{property} for #{class_name} #{@filter}")
        result = @http_client.widget_get(@filter).body.first[property.to_sym]
        LibyuiClient.logger.info("Found '#{property}=#{result}' for #{class_name} #{@filter}")
        result
      end

      def action(params)
        LibyuiClient.logger.info("Send #{params} action for #{class_name} #{@filter}")
        @http_client.widget_send_action(@filter, params)
      end

      # rubocop:disable Metrics/AbcSize
      def collect_all
        LibyuiClient.logger.info("Collect all #{class_name} widgets with filter #{@filter}")
        result = @http_client.widget_get(@filter).body
        LibyuiClient.logger.info("Found #{class_name} widgets for filter #{@filter}: #{result}")
        result.map do |widget|
          self.class.new(@http_client,
                         Validate.filter({ type: widget[:class], label: widget[:debug_label], id: widget[:id] }))
        end
      end
      # rubocop:enable Metrics/AbcSize

      private

      def class_name
        self.class.name.split('::').last
      end
    end
  end
end
