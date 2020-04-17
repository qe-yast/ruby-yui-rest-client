# frozen_string_literal: true

module LibyuiClient
  module Waitable
    def wait_until(timeout: LibyuiClient.timeout, interval: LibyuiClient.interval, message: nil, &block)
      Wait.until(timeout: timeout, interval: interval, message: message, object: self, &block)
      self
    end

    def wait_while(timeout: LibyuiClient.timeout, interval: LibyuiClient.interval, message: nil, &block)
      Wait.while(timeout: timeout, interval: interval, message: message, object: self, &block)
      self
    end
  end
end
