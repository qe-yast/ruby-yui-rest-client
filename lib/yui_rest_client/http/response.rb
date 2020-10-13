# frozen_string_literal: true

module YuiRestClient
  module Http
    class Response
      def initialize(res)
        @res = res
      end

      def body(regex_filter: {})
        result = JSON.parse(@res.body, symbolize_names: true)
        result.select do |widget|
          regex_filter.all? { |key, value| value.match(widget[key.to_sym]) }
        end
      rescue JSON::ParserError => e
        YuiRestClient.logger.error("Error while parsing JSON from response:\n"\
      "#{e.message}\n#{e.backtrace.inspect}")
      end
    end
  end
end
