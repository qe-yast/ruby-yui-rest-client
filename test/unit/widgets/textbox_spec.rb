# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Textbox do
      let(:widget_controller) { instance_double('widget_controller') }
      let(:filter) { FilterExtractor.new({ id: 'aliases' }) }
      subject { Textbox.new(widget_controller, filter) }

      describe '#max_length' do
        let(:response) { double('Response', { body: [{ input_max_length: 256 }] }) }
        it 'returns input max length' do
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.max_length).to eq(256)
        end
      end

      describe '#set' do
        it 'sets text' do
          expect(widget_controller).to receive(:send_action)
          expect(subject.set('test')).to equal(subject)
        end
      end

      describe '#password?' do
        let(:response) { double('Response', { body: [{ password_mode: true }] }) }
        it 'returns password mode' do
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.password?).to be_truthy
        end
      end

      describe '#valid_chars' do
        let(:response) { double('Response', { body: [{ valid_chars: '0123456789' }] }) }
        it 'returns valid_chars' do
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.valid_chars).to eq('0123456789')
        end
      end

      describe '#value' do
        let(:response) { double('Response', { body: [{ value: 'test' }] }) }
        it 'should return the text of the :value' do
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.value).to eq('test')
        end
      end
    end
  end
end
