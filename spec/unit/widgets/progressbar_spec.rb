# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Progressbar do
      let(:widget_controller) { instance_double('widget_controller') }
      let(:widget_filter) { FilterExtractor.new({ id: 'test_progressbar' }) }
      subject { Progressbar.new(widget_controller, widget_filter) }
      let(:max_value) { 1000 }
      let(:value) { 666 }
      let(:response) do
        double('Response', { body: [{ class: 'YProgressBar',
                                      id: 'test_progressbar',
                                      max_value: 1000,
                                      value: 666 }] })
      end

      describe '#max_value' do
        it 'returns the progressbar max value' do
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.max_value).to eq(1000)
        end
      end

      describe '#value' do
        it 'returns the progressbar current value' do
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.value).to eq(666)
        end
      end
    end
  end
end
