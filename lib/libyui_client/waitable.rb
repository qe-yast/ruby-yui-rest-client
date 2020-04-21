# frozen_string_literal: true

module LibyuiClient
  module Waitable
    # Waits until the block evaluation will return true, raises Error::TimeoutError on timeout.
    # @param timeout [Numeric] how long to wait (in seconds). Default is LibyuiClient.timeout.
    # @param interval [Numeric] time in seconds between attempts. Default is LibyuiClient.interval.
    # @message [String] message to be sent in case timeout is reached.
    # @raise Error::TimeoutError
    # @return [Waitable] waitable object
    # @example Wait for checkbox to be checked
    #   app.checkbox(id: 'test').wait_until(&:checked?)
    def wait_until(timeout: LibyuiClient.timeout, interval: LibyuiClient.interval, message: nil, &block)
      Wait.until(timeout: timeout, interval: interval, message: message, object: self, &block)
      self
    end

    # Waits while the block evaluation returns true, raises Error::TimeoutError on timeout.
    # @param timeout [Numeric] how long to wait (in seconds). Default is LibyuiClient.timeout.
    # @param interval [Numeric] time in seconds between attempts. Default is LibyuiClient.interval.
    # @message [String] message to be sent in case timeout is reached.
    # @raise Error::TimeoutError
    # @return [Waitable] waitable object
    # @example Wait for checkbox to be unchecked
    #   app.checkbox(id: 'test').wait_while(&:checked?)
    def wait_while(timeout: LibyuiClient.timeout, interval: LibyuiClient.interval, message: nil, &block)
      Wait.while(timeout: timeout, interval: interval, message: message, object: self, &block)
      self
    end
  end
end
