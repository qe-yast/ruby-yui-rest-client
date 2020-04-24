# frozen_string_literal: true

module LibyuiClient
  module Http
    class Response
      def initialize(res)
        @res = res
      end

      def body
        JSON.parse(@res.body, symbolize_names: true)
      rescue JSON::ParserError => e
        LibyuiClient.logger.error("Error while parsing JSON from response:\n"\
      "#{e.message}\n#{e.backtrace.inspect}")
      end
    end
  end
end
