# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a Label UI. It can be YLabel, YLabel_Heading
    class Label < Widgets::Base
      # Returns if label is a heading being represented in bold in the UI
      # Gets value from 'is_heading' parameter in JSON representation of YLabel_Heading.
      # @return [Boolean] true if it is a heading, false otherwise.
      # @example Check label with 'label' "Product name"
      #   {
      #     "class": "YLabel_Heading",
      #     "debug_label": "Product name ...",
      #     "is_heading": true,
      #     "label": "Product name",
      #     "text": "Product name"
      #   }
      # @example
      #   app.label(label: 'Product name').heading? # true
      def heading?
        heading_prop = property(:is_heading)
        !heading_prop.nil? && heading_prop == true
      end

      # Returns text value for the label.
      # @return [String] value
      # @example Get text value for YLabel, YLabelHeading
      #   {
      #     "class": "YLabel",
      #     "debug_label": "short message",
      #     "label": "test label",
      #     "text": "text label"
      #   }
      # @example
      #   text = app.label(label: 'test label').text # "text label"
      def text
        property(:text)
      end
    end
  end
end
