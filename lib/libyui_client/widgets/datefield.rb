# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a date field in the UI, namely YDateField.
    class Datefield < Widgets::Base
      # Sends action to set the value of date field. Accepts Date, Time or DateTime
      # object and sets value in ISO 8601 format YYYY-MM-DD.
      # @param date [Date] date to be set in date field
      # @return [Datefield] in case action is successful
      # @raise LibyuiClientError if parameter is not Date, DateTime or Time
      # @example Set date in date field with id 'test' to current date
      #   app.datefield(id: 'date').set(Time.now)
      # @example Set date in date field with id 'test' to 2002-12-29
      #   app.datefield(id: 'date').set(DateTime.new(2002,12,29))
      # @example Set date in date field with id 'test' to 2021-02-03
      #   app.datefield(id: 'date').set(Date.new(2001,2,3))
      def set(date)
        unless  [Date, DateTime, Time].any? { |c| date.is_a? c }
          raise Error::LibyuiClientError, 'Parameter is not Date, Time or DateTime'
        end

        action(action: Actions::ENTER_TEXT, value: date.strftime('%F'))
        self
      end

      # Returns text that is currently set for datefield.
      # Gets value from 'value' parameter in JSON representation of YDateField.
      # @return [String] value
      # @example Get value from datefield with id "date"
      #   {
      #       "class" : "YDateField",
      #       "debug_label" : "Date:",
      #       "hstretch" : true,
      #       "id" : "date",
      #       "label" : "&Date:",
      #       "notify" : true,
      #       "value" : "1989-11-09"
      #   }
      # @example
      #   app.datefield(id: 'date').value # '1989-11-09'
      def value
        property(:value)
      end
    end
  end
end
