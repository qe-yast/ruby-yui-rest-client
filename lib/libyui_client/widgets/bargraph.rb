# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a bar graph in the UI, namely YBarGraph.
    class Bargraph < Widgets::Base
      # Returns the list of segments in the bar graph. Each segment is defined by
      # label and value. Segment length is defined by proportional ratio of the
      # segment value. For instance, if segment values are 100, 200, 700: it means
      # first segment will take 100/1000=10%, second 20% and third one 70% accordingly.
      # @return [Array] array of [Hash] objects with :label and :value keys which
      #                 store label and segment value for given segment
      # @example Get segments from the bargraph with id "test_id"
      # {
      #   "class" : "YBarGraph",
      #   "id" : "test_id",
      #   "segments" :
      #   [
      #     {
      #       "label" : "Windows\nused\n%1 MB",
      #       "value" : 600
      #     },
      #     {
      #       "label" : "Windows\nfree\n%1 MB",
      #       "value" : 350
      #     },
      #     {
      #       "label" : "Linux\n%1 MB",
      #       "value" : 800
      #     }
      #   ],
      # }
      # @example
      #   app.bargraph(id: 'test_id').segments
      # @example
      #   app.bargraph(id: 'test_id').segments[1][:value]
      # @example
      #   app.bargraph(id: 'test_id').segments[1][:label]
      def segments
        property(:segments)
      end

      # Returns the labels list of all segments in the bar graph.
      # @return [Array] array of labels in order they are stored in segments hash.
      # @example Get labels of the segments in the bargraph with id "test_id"
      # @example
      #   app.bargraph(id: 'test_id').labels
      def labels
        segments.map { |segment| segment[:label] }
      end

      # Returns the values list of all segments in the bar graph.
      # @return [Array] array of values in order they are stored in segments hash.
      # @example Get values of the segments in the bargraph with id "test_id"
      # @example
      #   app.bargraph(id: 'test_id').values
      def values
        segments.map { |segment| segment[:value] }
      end
    end
  end
end
