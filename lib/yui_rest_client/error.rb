# frozen_string_literal: true

module LibyuiClient
  module Error
    class LibyuiClientError < StandardError; end

    class TimeoutError < LibyuiClientError; end

    class WidgetNotFoundError < LibyuiClientError; end

    class ItemNotFoundInWidgetError < LibyuiClientError; end
  end
end
