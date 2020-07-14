# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a multilinebox in the UI. It can be YMultiLineEdit.
    class Multilinebox < Widgets::Base
      # Returns maximum string length to set in the multilinebox
      # @return [Integer] maximum number of character to set in the multilinebox
      # @example Check maximum string length in multilinebox with id 'TEST_ID'
      #   }
      #      "class" : "YMultiLineEdit",
      #      "debug_label" : "test_label",
      #      "default_visible_lines" : 3,
      #      "hstretch" : true,
      #      "hweight" : 1,
      #      "id" : "\"TEST_ID\"",
      #      "input_max_length" : -1,
      #      "label" : "test_label",
      #      "value" : "",
      #      "vstretch" : true
      #   }
      # @example
      #   app.multilinebox(id: '"TEST_ID"').max_length
      #     # -1
      def max_length
        property(:input_max_length)
      end

      # Returns the default visible number of lines for the multilinebox
      # @return [Integer] default number of visible lines for the multilinebox
      # @example Check the default visible number of line for  multilinebox with id 'TEST_ID'
      #   }
      #      "class" : "YMultiLineEdit",
      #      "debug_label" : "test_label",
      #      "default_visible_lines" : 3,
      #      "hstretch" : true,
      #      "hweight" : 1,
      #      "id" : "\"TEST_ID\"",
      #      "input_max_length" : -1,
      #      "label" : "test_label",
      #      "value" : "",
      #      "vstretch" : true
      #   }
      # @example
      #   app.multilinebox(id: '"TEST_ID"').visible_lines
      #     # 3
      def visible_lines
        property(:default_visible_lines)
      end

      # Sends action to set the value of multilinebox.
      # @param value [String] text to be set in multilinebox
      # @return [Multilinebox] in case action is successful
      # @example Set text in multilinebox with id 'TEST_ID' to 'text'
      #   app.multilinebox(id: '"TEST_ID"').set("text\ntext in new line")
      def set(value)
        action(action: Actions::ENTER_TEXT, value: value)
        self
      end

      # Returns text that is currently set for multilinebox.
      # Gets value from 'value' parameter in JSON representation of YMultiLineEdit.
      # @return [String] text set as value in the multilinebox.
      # @example Get value from multilinebox with id "address"
      #   }
      #      "class" : "YMultiLineEdit",
      #      "debug_label" : "test_label",
      #      "default_visible_lines" : 3,
      #      "hstretch" : true,
      #      "hweight" : 1,
      #      "id" : "\"TEST_ID\"",
      #      "input_max_length" : -1,
      #      "label" : "test_label",
      #      "value" : "This is a \nmultiline\ntext",
      #      "vstretch" : true
      #   }
      # @example
      #   app.multilinebox(id: '"TEST_ID"').value # This is a \nmultiline\ntext
      def value
        property(:value)
      end
    end
  end
end
