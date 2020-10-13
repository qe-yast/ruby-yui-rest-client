# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a richtext in the UI. It can be YRichText.
    class Richtext < Widgets::Base
      # Sends action to click a link inside a richtext control in the UI.
      # @param value [String] href
      # @return [Richtext] in case action is successful
      # @example Click link with value 'test'
      #   items.click_link('test')
      def click_link(value)
        action(action: Actions::PRESS, value: value)
        self
      end

      # Returns text value for the richtext.
      # @return [String] value
      # @example Get text value for YRichText
      #   {
      #     "class": "YRichText",
      #     "enabled": false,
      #     "hstretch": true,
      #     "id": "test",
      #     "text": "<small>Select something here</small>",
      #     "vstretch": true,
      #     "vweight": 25
      #   }
      # @example
      #   text = app.richtext(id: 'test').text # "<small>Select something here</small>"
      def text
        property(:text)
      end
    end
  end
end
