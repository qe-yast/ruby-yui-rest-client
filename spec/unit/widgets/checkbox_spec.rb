# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Checkbox do
      let(:widget_controller) { instance_double('widget_controller') }
      let(:widget_filter) { FilterExtractor.new({ id: 'change_now' }) }
      subject { Checkbox.new(widget_controller, widget_filter) }
      describe '#toggle' do
        it 'has a request with action toggle' do
          allow(widget_controller).to receive(:send_action)
          expect(subject).to receive(:action).with({ action: 'toggle' })
          expect(subject.toggle).not_to be_nil
        end
      end

      describe '#check' do
        it 'has a request with action check' do
          allow(widget_controller).to receive(:send_action)
          expect(subject).to receive(:action).with({ action: 'check' })
          expect(subject.check).not_to be_nil
        end
      end

      describe '#uncheck' do
        it 'has a request with action uncheck' do
          allow(widget_controller).to receive(:send_action)
          expect(subject).to receive(:action).with({ action: 'uncheck' })
          expect(subject.uncheck).not_to be_nil
        end
      end

      describe '#checked?' do
        it 'should return the correct state of the component' do
          response = double('Response', { body: [{ 'class': 'YCheckBox',
                                                   debug_label: 'Change the Time Now',
                                                   id: 'change_now',
                                                   label: 'Chan&ge the Time Now',
                                                   notify: true,
                                                   value: true }] })
          allow(widget_controller).to receive(:find).and_return(response)
          expect(subject.checked?).to be_truthy
        end
      end
    end
  end
end
