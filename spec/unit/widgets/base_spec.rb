# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Base do
      let(:widget_controller) { instance_double('widget_controller') }
      let(:widget_filter) { FilterExtractor.new({ id: 'foo' }) }

      describe '#exists?' do
        let(:response) { instance_double('Response', { body: '[{ "id": "foo", "debug_label": "Cancel" }]' }) }
        subject { Base.new(widget_controller, widget_filter) }

        context 'when filter exist' do
          it 'returns true' do
            expect(widget_controller).to receive(:find).and_return(response)
            expect(subject.exists?).to be_truthy
          end
        end
        context 'non-existent widget' do
          it 'returns false' do
            allow(widget_controller).to receive(:find) do
              raise(Error::WidgetNotFoundError)
            end
            @obj = Base.new(widget_controller, { id: '' })
            expect(subject.exists?).to be_falsy
          end
        end
      end

      describe '#property' do
        let(:response) { instance_double('Response', { body: [{ id: 'foo', debug_label: 'Cancel' }] }) }
        before do
          allow(widget_controller).to receive(:find).and_return(response)
          @obj = Base.new(widget_controller, widget_filter)
        end
        context 'when the property exists' do
          it 'returns the value of the property' do
            expect(@obj.property(:id)).to eq('foo')
          end
        end
      end

      describe '#action' do
        pending
      end

      describe '#collect_all' do
        let(:widget1) do
          { 'class': 'YCheckBox',
            debug_label: 'Change the Time Now',
            id: 'change_now',
            label: 'Chan&ge the Time Now',
            notify: true,
            value: true }
        end
        let(:widget2) do
          { 'class': 'YCheckBox',
            debug_label: 'Change the Date Now',
            id: 'change_now2',
            label: 'Chan&ge the Date Now',
            notify: true,
            value: true }
        end
        let(:response) { instance_double('Response', { body: [widget1, widget2] }) }
        before do
          allow(widget_controller).to receive(:find).and_return(response)
          @obj = Checkbox.new(widget_controller, widget_filter)
        end
        context 'when response contains two Widgets' do
          it 'returns an Array of two new Widgets' do
            arr = @obj.collect_all
            expect(arr).to be_instance_of(Array)
            arr.each do |widget|
              expect(widget).to be_instance_of(Checkbox)
            end
            expect(arr.size).to eq(2)
          end
        end
      end

      describe '#enabled?' do
        context 'when widget value is true' do
          subject { Base.new(widget_controller, widget_filter) }
          it 'returns true' do
            response = instance_double('Response', { body: [{ id: 'foo',
                                                              debug_label: 'Cancel',
                                                              enabled: true }] })
            allow(widget_controller).to receive(:find).and_return(response)
            expect(subject.enabled?).to be_truthy
          end
        end
        context 'when widget value does not have "enabled" property' do
          subject(:widget) { Base.new(widget_controller, widget_filter) }
          it 'is counted as enabled and returns true' do
            allow(widget).to receive(:property).and_return(nil)
            expect(widget.enabled?).to be_truthy
          end
        end
      end
    end
  end
end
