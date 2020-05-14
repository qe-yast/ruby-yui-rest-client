# frozen_string_literal: true

module LibyuiClient
  module Widgets
    class Base
      include Waitable

      def initialize(widget_controller, filter)
        @widget_controller = widget_controller
        @filter = filter
        @timeout = LibyuiClient.timeout
        @interval = LibyuiClient.interval
      end

      # Allows to check if widget exists on the current screen or not.
      # Can be called against any widget.
      # @return [Boolean] true if widget exists, false otherwise.
      # @example Check if button with id 'test' exists
      #   app.button(id: 'test').exists? # true
      def exists?
        LibyuiClient.logger.info("Checking if #{class_name} with #{@filter} exists")
        @widget_controller.find(@filter, timeout: 0, interval: @interval).body
        LibyuiClient.logger.info("#{class_name} exists: #{@filter}")
        true
      rescue Error::WidgetNotFoundError
        LibyuiClient.logger.info("#{class_name} does not exist: #{@filter}")
        false
      end

      # Allows to check if widget enabled or disabled.
      # Can be called against any widget. Widget that does not have "enabled" property is counted as enabled.
      # @return [Boolean] true if widget enabled, false otherwise.
      # @example Check if button with id 'test' enabled
      #   app.button(id: 'test').enabled? # true
      def enabled?
        enabled_prop = property(:enabled)
        enabled_prop.nil? || enabled_prop == true
      end

      # Returns debug_label value for widget.
      # Can be called against any widget.
      # @return debug_label [String] value of debug_label property
      # @example Get debug_label value for button
      #   {
      #     "class": "YQWizardButton",
      #     "debug_label": "Cancel",
      #     "fkey": 9,
      #     "id": "cancel",
      #     "label": "&Cancel"
      #   }
      # @example
      #   fkey = app.button(id: 'cancel').debug_label # "Cancel"
      def debug_label
        property(:debug_label)
      end

      # Returns value of widget property.
      # This method can be used to retrieve value of some specific property,
      # but widget does not have a method to return the value.
      # Can be called against any widget.
      # @param property [Symbol] symbolic name of the property to get value for.
      # @return [Object] value for property of a widget
      # @example Get value of "label" property for button with id "test"
      #   value = app.button(id: 'test').property(:label)
      def property(property)
        LibyuiClient.logger.info("Get #{property} for #{class_name} #{@filter}")
        result = @widget_controller.find(@filter, timeout: @timeout, interval: @interval).body.first[property.to_sym]
        LibyuiClient.logger.info("Found '#{property}=#{result}' for #{class_name} #{@filter}")
        result
      end

      # This method can be used to send any action to widget.
      # Can be called against any widget.
      # @param params [Hash] actions to be sent (e.g. action: 'press').
      # @example Send action 'press' to button widget.
      #   app.button(id: 'test').action(action: 'press')
      def action(params)
        LibyuiClient.logger.info("Send #{params} action for #{class_name} #{@filter}")
        @widget_controller.send_action(@filter, params, timeout: @timeout, interval: @interval)
      end

      # Get all widgets found with filter.
      # The method is mainly introduced for "type" filter, which can return an array of widgets.
      # It only makes sense to use this method whenever server side filters allow to find individually those
      # collected widgets, otherwise those will not be able to access their internal properties.
      # @return [Array] array of deserialized widgets.
      # Then actions that are specified for the widget can be called while iterating over the returned array.
      # @example Get all checkboxes and check all of them
      #   checkboxes = app.checkbox(type: "YCheckBox").collect_all
      #   checkboxes.each{ |checkbox| puts checkbox.check }
      def collect_all
        LibyuiClient.logger.info("Collect all #{class_name} widgets with filter #{@filter}")
        result = @widget_controller.find(@filter, timeout: @timeout, interval: @interval).body
        LibyuiClient.logger.info("Found widgets for filter #{@filter}: #{result}")
        result.map do |widget|
          self.class.new(@widget_controller,
                         Validate.filter(type: widget[:class], label: widget[:label], id: widget[:id]))
        end
      end

      private

      def class_name
        self.class.name.split('::').last
      end
    end
  end
end
