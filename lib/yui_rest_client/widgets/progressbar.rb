# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a Progressbar in UI. It can be YProgressBar.
    class Progressbar < Widgets::Base
      # Returns the current value of progressbar.
      # Gets value from 'value' parameter in JSON representation of YProgressBar.
      # @return [Integer] current value of progressbar.
      # @example Get progressbar value, with id 'initProg'
      #   {
      #     "class" : "YProgressBar",
      #     "hstretch" : true,
      #     "id" : "initProg",
      #     "label" : "Disk",
      #     "max_value" : 1000,
      #     "value" : 666
      #   }
      #   app.progressbar(id: 'initProg').value
      #	    # 663
      def value
        property(:value)
      end

      # Returns the max value of progressbar.
      # Gets value from 'max_value' parameter in JSON representation of YProgressBar.
      # @return [Integer] max value of the progressbar.
      # @example Get progressbar max_value, with id 'initProg'
      #   {
      #     "class" : "YProgressBar",
      #     "hstretch" : true,
      #     "id" : "initProg",
      #     "label" : "Disk",
      #     "max_value" : 1000,
      #     "value" : 666
      #   }
      # @example
      #   app.progressbar(id: 'initProg').max_value
      #     # 1000
      def max_value
        property(:max_value)
      end
    end
  end
end
