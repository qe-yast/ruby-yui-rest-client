# frozen_string_literal: true

module LibyuiClient
  module Http
    class WidgetController
      def initialize(host:, port:)
        @host = host
        @port = port
        @timeout = LibyuiClient.timeout
        @interval = LibyuiClient.interval
      end

      # Find a widget using the filter.
      # @param filter [Hash] identifiers to find a widget
      # @return [Response]
      def find(filter)
        res = nil
        Wait.until(timeout: @timeout, interval: @interval) do
          uri = HttpClient.compose_uri(@host, @port, "/#{API_VERSION}/widgets", filter)
          res = HttpClient.http_get(uri)
          Response.new(res) if res.is_a?(Net::HTTPOK)
        end
      rescue Error::TimeoutError
        rescue_errors(res)
      end

      # Perform an action on the widget.
      # @param filter [Hash] identifiers to find a widget
      # @param action [Hash] what to do with the widget
      # @return [Response]
      def send_action(filter, action)
        res = nil
        Wait.until(timeout: @timeout, interval: @interval) do
          uri = HttpClient.compose_uri(@host, @port, "/#{API_VERSION}/widgets",
                                       filter.merge(action))
          res = HttpClient.http_post(uri)
          Response.new(res) if res.is_a?(Net::HTTPOK)
        end
      rescue Error::TimeoutError
        rescue_errors(res)
      end

      private

      def rescue_errors(response)
        raise Error::WidgetNotFoundError if response.is_a?(Net::HTTPNotFound)

        raise Error::ItemNotFoundInWidgetError if response.is_a?(Net::HTTPUnprocessableEntity)

        raise Error::LibyuiClientError
      end
    end
  end
end
