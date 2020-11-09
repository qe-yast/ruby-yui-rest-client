# frozen_string_literal: true

require 'rspec'

module YuiRestClient
  module Widgets
    RSpec.describe Table do
      let(:widget_controller) { instance_double('widget_controller') }
      let(:filter) { FilterExtractor.new({ id: 'foo' }) }
      let(:header0) { 'header0' }
      let(:header1) { 'header1' }
      let(:headers) { [header0, header1] }
      let(:cell0) { 'cell0' }
      let(:cell1) { 'cell1' }
      let(:row0) { [cell0, '', '', ''] }
      let(:row1) { [cell1, '', '', ''] }
      let(:rows) { [row0, row1] }
      let(:table_with_rows) do
        double('Response', { body: [{ header: headers,
                                      items: [
                                        { labels: row0 },
                                        { labels: row1, selected: true }
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
            expect(subject).to receive(:action).with({ action: 'select', value: cell0, column: 0 })
            expect(subject.select(value: cell0, column: header0)).to equal(subject)
          end
        end
        context 'when column is not provided' do
          it 'sends select action' do
            expect(subject).to receive(:action).with({ action: 'select', value: cell0 })
            expect(subject.select(value: cell0)).to equal(subject)
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
            expect(subject).to receive(:action).with({ action: 'select', value: cell0 })
            expect(subject.select(value: cell0, row: 0)).to equal(subject)
          end
        end
      end

      describe '#selected_items' do
        let(:rows_selected) { [row1] }
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
