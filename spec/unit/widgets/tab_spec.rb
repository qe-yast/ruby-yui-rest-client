# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Tab do
      let(:widget_controller) { instance_double('widget_controller') }
      let(:filter) { FilterExtractor.new({ id: 'foo' }) }
      subject { Tab.new(widget_controller, filter) }
      let(:tab1) { 'tab1' }
      let(:tab2) { 'tab2' }
      let(:tabs) { [tab1, tab2] }
      let(:response) do
        double('Response', { body: [{ items: [{ label: 'tab1' }, { label: 'tab2', selected: true }] }] })
      end

      describe '#items' do
        it 'lists items' do
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.items).to match_array(tabs)
        end
      end

      describe '#select' do
        it 'selects tab' do
          expect(widget_controller).to receive(:send_action)
          expect(subject.select(tab2)).to equal(subject)
        end
      end

      describe '#selected_item' do
        it 'returs selected item' do
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.selected_item).to eql(tab2)
        end
      end
    end
  end
end
