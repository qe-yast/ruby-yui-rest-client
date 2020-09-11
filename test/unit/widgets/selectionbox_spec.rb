# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Selectionbox do
      let(:widget_controller) { instance_double('widget_controller') }
      let(:widget_filter) { FilterExtractor.new({ id: 'test_selectionbox' }) }
      subject { Selectionbox.new(widget_controller, widget_filter) }
      let(:item1) { 'item1' }
      let(:item2) { 'item2' }
      let(:item3) { 'item3' }
      let(:items) { [item1, item2, item3] }
      let(:response) do
        double('Response', { body: [{ class: 'YSelectionBox',
                                      id: 'test_selectionbox',
                                      items: [{ label: 'item1',
                                                selected: true },
                                              { label: 'item2' },
                                              { label: 'item3' }],
                                      items_count: 3 }] })
      end

      describe '#select' do
        it 'call select action for the defined value' do
          allow(widget_controller).to receive(:send_action)
          expect(subject).to receive(:action).with({ action: 'select', value: item1 })
          expect(subject.select(item1)).to equal(subject)
        end
      end

      describe '#items' do
        it 'returns item list of the widget' do
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.items).to match_array(items)
        end
      end

      describe '#selected_item' do
        it 'returns the selected item' do
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.selected_item).to equal(item1)
        end
      end
    end
  end
end
