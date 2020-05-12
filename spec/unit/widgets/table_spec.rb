# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Table do
      let(:widget_controller) { instance_double('widget_controller') }
      let(:widget_filter) { { id: 'foo' } }
      subject { Table.new(widget_controller, widget_filter) }
      describe '#select_row' do
        it 'sends select action' do
          allow(widget_controller).to receive(:send_action)
          expect(subject).to receive(:action).with({ action: 'select', column: 0, value: 'test.item.1' })
          expect(subject.select_row(value: 'test.item.1', column_id: 0)).to be_instance_of(Table)
        end
      end
    end
  end
end
