# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Button do
      let(:widget_controller) { instance_double('widget_controller') }
      let(:widget_filter) { FilterExtractor.new({ id: 'foo' }) }
      subject { Button.new(widget_controller, widget_filter) }
      describe '#click' do
        it 'has a request with action press' do
          allow(widget_controller).to receive(:send_action) {}
          expect(subject).to receive(:action).with({ action: 'press' })
          subject.click
        end
      end

      describe '#fkey' do
        it 'returns the correct fkey number' do
          response = double('Response', { body: [{ id: 'cancel',
                                                   debug_label: 'Cancel',
                                                   fkey: 9 }] })
          allow(widget_controller).to receive(:find).and_return(response)
          allow(widget_controller).to receive(:property)
          expect(subject).to receive(:fkey).and_return(9)
          subject.fkey
        end
      end
    end
  end
end
