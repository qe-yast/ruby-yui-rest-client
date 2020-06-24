# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Numberbox do
      let(:widget_controller) { instance_double('widget_controller') }
      let(:filter) { FilterExtractor.new({ id: 'aliases' }) }
      subject { Numberbox.new(widget_controller, filter) }

      describe '#min_value' do
        let(:response) { double('Response', { body: [{ min_value: 0 }] }) }
        it 'returns min value' do
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.min_value).to eq(0)
        end
      end

      describe '#max_value' do
        let(:response) { double('Response', { body: [{ max_value: 65_535 }] }) }
        it 'returns max value' do
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.max_value).to eq(65_535)
        end
      end

      describe '#set' do
        it 'sets text' do
          expect(widget_controller).to receive(:send_action)
          expect(subject.set(8686)).to equal(subject)
        end
      end

      describe '#value' do
        let(:response) { double('Response', { body: [{ value: 'test' }] }) }
        it 'returns value currently set' do
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.value).to eq('test')
        end
      end
    end
  end
end
