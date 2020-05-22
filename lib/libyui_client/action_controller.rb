# frozen_string_literal: true

module LibyuiClient
  class ActionController
    def initialize(widget_controller, filter)
      @widget_controller = widget_controller
      @filter = filter
      @timeout = LibyuiClient.timeout
      @interval = LibyuiClient.interval
    end

    # This method can be used to send any action to widget.
    # Can be called against any widget.
    # @param params [Hash] actions to be sent (e.g. action: 'press').
    # @example Send action 'press' to button widget.
    #   app.button(id: 'test').action(action: 'press')
    def send_action(action)
      @widget_controller.send_action(@filter, action, timeout: @timeout, interval: @interval)
    end
  end
end
