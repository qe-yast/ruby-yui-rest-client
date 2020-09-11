# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Tree do
      let(:widget_controller) { instance_double('widget_controller') }
      let(:filter) { FilterExtractor.new({ id: 'foo' }) }
      subject { Tree.new(widget_controller, filter) }
      let(:items) do
        %w[node1 node1|node1_1 node1|node1_2 node1|node1_2|node1_2_1 node1|node1_2|node1_2_2 node2]
      end
      let(:response) do
        double('Response',
               { body: [{ items: [
                 {
                   children: [
                     {
                       label: 'node1_1'
                     },
                     {
                       children: [
                         {
                           label: 'node1_2_1'
                         },
                         {
                           label: 'node1_2_2',
                           selected: true
                         }
                       ],
                       label: 'node1_2'
                     }
                   ],
                   label: 'node1'
                 },
                 {
                   label: 'node2'
                 }
               ] }] })
      end
      let(:node) { 'node1|node1_2|node1_2_2' }

      describe '#items' do
        it 'lists items' do
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.items).to match_array(items)
        end
      end

      describe '#select' do
        it 'selects tree node' do
          expect(widget_controller).to receive(:send_action)
          expect(subject.select(node)).to equal(subject)
        end
      end

      describe '#selected_item' do
        it 'lists items' do
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.selected_item).to eql(node)
        end
      end
    end
  end
end
