# frozen_string_literal: true

module YuiRestClient
  module Waitable
    # Waits until the block evaluation will return true, raises Error::TimeoutError on timeout.
    # @param timeout [Numeric] how long to wait (in seconds). Default is YuiRestClient.timeout.
    # @param interval [Numeric] time in seconds between attempts. Default is YuiRestClient.interval.
    # @param message [String] message to be sent in case timeout is reached.
    # @raise Error::TimeoutError
    # @return [Waitable] waitable object
    # @example Wait for checkbox to be checked
    #   app.checkbox(id: 'test').wait_until(&:checked?)
    def wait_until(timeout: YuiRestClient.timeout, interval: YuiRestClient.interval, message: nil, &block)
      @timeout = timeout
      @interval = interval
      Wait.until(timeout: timeout, interval: interval, message: message, object: self, &block)
      @timeout = YuiRestClient.timeout
      @interval = YuiRestClient.interval
      self
    end

    # Waits while the block evaluation returns true, raises Error::TimeoutError on timeout.
    # @param timeout [Numeric] how long to wait (in seconds). Default is YuiRestClient.timeout.
    # @param interval [Numeric] time in seconds between attempts. Default is YuiRestClient.interval.
    # @param message [String] message to be sent in case timeout is reached.
    # @raise Error::TimeoutError
    # @return [Waitable] waitable object
    # @example Wait for checkbox to be unchecked
    #   app.checkbox(id: 'test').wait_while(&:checked?)
    def wait_while(timeout: YuiRestClient.timeout, interval: YuiRestClient.interval, message: nil, &block)
      @timeout = timeout
      @interval = interval
      Wait.while(timeout: timeout, interval: interval, message: message, object: self, &block)
      @timeout = YuiRestClient.timeout
      @interval = YuiRestClient.interval
      self
    end
  end
end
