# frozen_string_literal: true

module YuiRestClient
  module Http
    class VersionController
      def initialize(host:, port:)
        @host = host
        @port = port
        @timeout = YuiRestClient.timeout
        @interval = YuiRestClient.interval
      end

      # Gets server api version, so one could compare compatibility and detect
      # if newer version was deployed
      # @return server side REST API version
      def api_version
        Wait.until(timeout: @timeout, interval: @interval) do
          res = HttpClient.http_get(HttpClient.compose_uri(@host, @port, '/version'))
          raise Error::YuiRestClientError unless res.is_a?(Net::HTTPOK)

          JSON.parse(res.body)['api_version']
        end
      end
    end
  end
end
