# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Timefield do
      let(:id) { { id: 'time' } }
      let(:widget_controller) { instance_double('widget_controller') }
      let(:filter) { FilterExtractor.new(id) }
      let(:set_params) { { action: 'enter_text', value: '17:29:59' } }
      subject { Timefield.new(widget_controller, filter) }

      describe '#set' do
        context 'use DateTime to set value' do
          it 'it sets date field in ISO 8601 format' do
            expect(widget_controller).to receive(:send_action).with(id, set_params)
            expect(subject.set(DateTime.new(2001, 2, 3, 17, 29, 59))).to equal(subject)
          end
        end
        context 'use Time to set value' do
          it 'it sets date field in ISO 8601 format' do
            expect(widget_controller).to receive(:send_action).with(id, set_params)
            expect(subject.set(Time.new(2001, 2, 3, 17, 29, 59))).to equal(subject)
          end
        end
        context 'use Date to set time field value' do
          it 'it raises LibyuiClientError' do
            expect { subject.set(Date.new(1998, 1, 1)) }.to raise_error(Error::LibyuiClientError)
          end
        end
      end
      describe '#value' do
        let(:response) { double('Response', { body: [{ value: '20:15:00' }] }) }
        it 'should return the text of the :value' do
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.value).to eq('20:15:00')
        end
      end
    end
  end
end
