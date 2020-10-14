# frozen_string_literal: true

module YuiRestClient
  module Error
    class YuiRestClientError < StandardError; end

    class TimeoutError < YuiRestClientError; end

    class WidgetNotFoundError < YuiRestClientError; end

    class ItemNotFoundInWidgetError < YuiRestClientError; end
  end
end
