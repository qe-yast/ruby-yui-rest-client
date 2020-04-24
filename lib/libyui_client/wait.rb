# frozen_string_literal: true

module LibyuiClient
  module Wait
    def self.until(timeout:, interval:, message: nil, object: nil)
      Timer.wait(timeout, interval) do
        result = yield(object)
        return result if result
      end
      raise Error::TimeoutError, "timed out after #{timeout} seconds. #{message}"
    end

    def self.while(timeout:, interval:, message: nil, object: nil)
      Timer.wait(timeout, interval) do
        result = yield(object)
        return unless result
      end
      raise Error::TimeoutError, "timed out after #{timeout} seconds. #{message}"
    end
  end
end
