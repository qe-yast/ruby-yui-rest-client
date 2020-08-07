# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a DateField in the UI, namely YDateField.
    class Timefield < Widgets::Base
      # Sends action to set the value of time field. Accepts Time or DateTime
      # object and sets value in ISO 8601 format HH:MM:SS.
      # @param time [Time] time to be set in the time field
      # @return [Timefield] in case action is successful
      # @raise LibyuiClientError if parameter is not DateTime or Time
      # @example Set current time in the time field with id 'test' using Time
      #   app.timefield(id: 'date').set(Time.now)
      # @example Set custom time in the field with id 'test' to 04:05:06
      #   app.timefield(id: 'date').set(DateTime.new(2001,2,3,4,5,6))
      def set(time)
        unless  [DateTime, Time].any? { |c| time.is_a? c }
          raise Error::LibyuiClientError, 'Parameter is not Date, Time or DateTime'
        end

        action(action: Actions::ENTER_TEXT, value: time.strftime('%T'))
        self
      end
    end
  end
end
