# frozen_string_literal: true

module YuiRestClient
  module Http
    module HttpClient
      module_function

      def http_get(uri)
        YuiRestClient.logger.debug("Request: [GET] #{uri}")
        res = Net::HTTP.get_response(uri)
        YuiRestClient.logger.debug("Response: [#{res.code}]\n#{res.body}")
        res
      end

      def http_post(uri)
        YuiRestClient.logger.debug("Request: [POST] #{uri}")
        # a trick how to add query parameters to a POST request,
        # the usual Net::HTTP.post(uri, data) does not allow using a query
        req = Net::HTTP::Post.new("#{uri.path}?#{uri.query}")
        http = Net::HTTP.new(uri.host, uri.port)
        res = http.request(req)
        YuiRestClient.logger.debug("Response: [#{res.code}]\n#{res.body}")
        res
      end

      def compose_uri(host, port, path, params = {})
        URI::HTTP.build(
          host: host,
          port: port,
          path: path,
          query: URI.encode_www_form(params)
        )
      end
    end
  end
end
