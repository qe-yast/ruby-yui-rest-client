# frozen_string_literal: true

module LibyuiClient
  module Timer
    module_function

    def wait(timeout, interval)
      return yield if timeout.zero?

      end_time = Time.now.to_f + timeout
      while Time.now.to_i <= end_time
        yield
        sleep interval
      end
    end
  end
end
