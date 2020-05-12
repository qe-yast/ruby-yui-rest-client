# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Textbox do
      let(:widget_controller) { instance_double('widget_controller') }
      let(:widget_filter) { { id: 'aliases' } }
      subject { Textbox.new(widget_controller, widget_filter) }
      describe '#set' do
        it 'sends POST with action enter_text and correct value' do
          expect(subject).to receive(:action).with({ action: 'enter_text', value: 'test' })
          subject.set('test')
        end
      end

      describe '#value' do
        it 'should return the text of the :value' do
          response = double('Response', { body: [{ 'class': 'InputField',
                                                   debug_label: 'Host Aliases',
                                                   hstretch: true,
                                                   id: 'aliases',
                                                   label: 'Hos&t Aliases',
                                                   password_mode: false,
                                                   value: 'test' }] })
          allow(widget_controller).to receive(:find).and_return(response)
          allow(widget_controller).to receive(:property)
          expect(subject.value).to eq('test')
        end
      end
    end
  end
end
