# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Radiobutton do
      let(:widget_controller) { instance_double('widget_controller') }
      let(:widget_filter) { FilterExtractor.new({ id: 'manual' }) }
      subject { Radiobutton.new(widget_controller, widget_filter) }
      describe '#select' do
        it 'call select action' do
          allow(widget_controller).to receive(:send_action)
          expect(subject).to receive(:action).with({ action: 'select' })
          expect(subject.select).to be_instance_of(Radiobutton)
        end
      end

      describe '#selected' do
        it 'should return radiobutton value' do
          response = double('Response', { body: [{ 'class': 'YRadiobutton',
                                                   debug_label: 'Manually',
                                                   id: 'manual',
                                                   label: '&Manually',
                                                   notify: true,
                                                   value: false }] })
          allow(widget_controller).to receive(:find).and_return(response)
          allow(widget_controller).to receive(:property)
          expect(subject.selected?).to be_falsy
        end
      end
    end
  end
end
