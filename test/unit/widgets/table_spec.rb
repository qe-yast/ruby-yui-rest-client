# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Table do
      let(:widget_controller) { instance_double('widget_controller') }
      let(:filter) { FilterExtractor.new({ id: 'foo' }) }
      let(:header_0) { 'header_0' }
      let(:header_1) { 'header_1' }
      let(:headers) { [header_0, header_1] }
      let(:cell_0_0) { 'cell_0_0' }
      let(:cell_1_0) { 'cell_1_0' }
      let(:row_0) { [cell_0_0, '', '', ''] }
      let(:row_1) { [cell_1_0, '', '', ''] }
      let(:rows) { [row_0, row_1] }
      let(:table_with_rows) do
        double('Response', { body: [{ header: headers,
                                      items: [
                                        { labels: row_0 },
                                        { labels: row_1, selected: true }
                                      ] }] })
      end
      subject { Table.new(widget_controller, filter) }

      describe '#empty?' do
        context 'when table is empty' do
          let(:table_empty) { double('Response', { body: [{ items: nil }] }) }
          it 'returns true' do
            allow(widget_controller).to receive(:find).and_return(table_empty)
            expect(subject.empty?).to be_truthy
          end
        end
        context 'when table contains rows' do
          it 'returns false' do
            allow(widget_controller).to receive(:find).and_return(table_with_rows)
            expect(subject.empty?).to be_falsy
          end
        end
      end

      describe '#items' do
        it 'lists items' do
          allow(widget_controller).to receive(:find).and_return(table_with_rows)
          expect(subject.items).to eql(rows)
        end
      end

      describe '#select' do
        let(:response) { double('Response', { body: [{ header: headers }] }) }
        before do
          allow(widget_controller).to receive(:find).and_return(response)
          allow(widget_controller).to receive(:send_action)
        end
        context 'when column is provided' do
          it 'sends select action' do
            expect(subject).to receive(:action).with({ action: 'select', value: cell_0_0, column: 0 })
            expect(subject.select(value: cell_0_0, column: header_0)).to equal(subject)
          end
        end
        context 'when column is not provided' do
          it 'sends select action' do
            expect(subject).to receive(:action).with({ action: 'select', value: cell_0_0 })
            expect(subject.select(value: cell_0_0)).to equal(subject)
          end
        end
        context 'when row is provided' do
          it 'sends select action using row' do
            expect(subject).to receive(:action).with({ action: 'select', row: 0 })
            expect(subject.select(row: 0)).to equal(subject)
          end
        end
        context 'when value and row are provided' do
          it 'sends select action using row' do
            expect(subject).to receive(:action).with({ action: 'select', value: cell_0_0 })
            expect(subject.select(value: cell_0_0, row: 0)).to equal(subject)
          end
        end
      end

      describe '#selected_items' do
        let(:rows_selected) { [row_1] }
        it 'lists selected items' do
          allow(widget_controller).to receive(:find).and_return(table_with_rows)
          expect(subject.selected_items).to eql(rows_selected)
        end
      end

      describe '#header' do
        it 'lists header values' do
          allow(widget_controller).to receive(:find).and_return(table_with_rows)
          expect(subject.header).to eql(headers)
        end
      end
    end
  end
end
