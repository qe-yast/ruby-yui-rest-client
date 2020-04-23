# frozen_string_literal: true

module LibyuiClient
  module Timer
    module_function

    # Execute code block with the interval until timeout reached.
    # @param timeout [Numeric] how many time in seconds to wait
    # @param interval [Numeric] time in seconds between attempts
    def wait(timeout, interval)
      return yield if timeout.zero?

      end_time = Time.now.to_f + timeout
      while Time.now.to_f <= end_time
        yield
        sleep interval
      end
    end
  end
end
