# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Bargraph do
      let(:widget_controller) { instance_double('WidgetController') }
      let(:filter) { FilterExtractor.new({ id: 'foo' }) }
      let(:segments) do
        [{ label: 'segment1', value: '10' },
         { label: 'segment2', value: '30' },
         { label: 'segment3', value: '70' }]
      end
      let(:bargraph_with_segments) { double('Response', { body: [{ segments: segments }] }) }
      subject { Bargraph.new(widget_controller, filter) }

      describe '#segments' do
        it 'lists segments' do
          allow(widget_controller).to receive(:find).and_return(bargraph_with_segments)
          expect(subject.segments).to eql(segments)
        end
        context 'bar graph contains no segments' do
          let(:empty_bargraph) { double('Response', { body: [{ segments: [] }] }) }
          it 'returns empty array' do
            allow(widget_controller).to receive(:find).and_return(empty_bargraph)
            expect(subject.segments).to eql([])
          end
        end
      end

      describe '#labels' do
        it 'lists labels' do
          allow(widget_controller).to receive(:find).and_return(bargraph_with_segments)
          expect(subject.labels).to eql(segments.map { |s| s[:label] })
        end
        context 'bar graph contains no segments' do
          let(:empty_bargraph) { double('Response', { body: [{ segments: [] }] }) }
          it 'returns empty array' do
            allow(widget_controller).to receive(:find).and_return(empty_bargraph)
            expect(subject.labels).to eql([])
          end
        end
      end
      describe '#values' do
        it 'lists values' do
          allow(widget_controller).to receive(:find).and_return(bargraph_with_segments)
          expect(subject.values).to eql(segments.map { |s| s[:value] })
        end
        context 'bar graph contains no segments' do
          let(:empty_bargraph) { double('Response', { body: [{ segments: [] }] }) }
          it 'returns empty array' do
            allow(widget_controller).to receive(:find).and_return(empty_bargraph)
            expect(subject.labels).to eql([])
          end
        end
      end
    end
  end
end
