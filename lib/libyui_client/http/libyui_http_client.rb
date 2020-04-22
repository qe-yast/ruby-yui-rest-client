# frozen_string_literal: true

module LibyuiClient
  module Http
    class LibyuiHttpClient
      def initialize(host:, port:)
        @host = host
        @port = port
      end

      def widget_get(filter, timeout: LibyuiClient.timeout, interval: LibyuiClient.interval)
        res = nil
        Wait.until(timeout: timeout, interval: interval) do
          uri = HttpClient.compose_uri(@host, @port, '/widgets', filter)
          res = HttpClient.http_get(uri)
          Response.new(res) if res.is_a?(Net::HTTPOK)
        end
      rescue Error::TimeoutError
        rescue_widget_errors(res)
      end

      def widget_send_action(filter, action, timeout: LibyuiClient.timeout, interval: LibyuiClient.interval)
        res = nil
        Wait.until(timeout: timeout, interval: interval) do
          uri = HttpClient.compose_uri(@host, @port, '/widgets',
                                       filter.merge(action))
          res = HttpClient.http_post(uri)
          Response.new(res) if res.code.to_i == 200
        end
      rescue Error::TimeoutError
        rescue_widget_errors(res)
      end

      private

      def rescue_widget_errors(response)
        raise Error::WidgetNotFoundError if response.is_a?(Net::HTTPNotFound)

        raise Error::ItemNotFoundInWidgetError if response.is_a?(Net::HTTPUnprocessableEntity)

        raise Error::LibyuiClientError
      end
    end
  end
end
