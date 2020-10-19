# frozen_string_literal: true

require 'rspec'

module YuiRestClient
  module Widgets
    RSpec.describe Menucollection do
      let(:widget_controller) { instance_double('widget_controller') }
      let(:filter) { FilterExtractor.new({ id: 'foo' }) }
      subject { Menucollection.new(widget_controller, filter) }
      let(:menuitem1) { 'menuitem1' }
      let(:menuitem2) { 'menuitem2' }
      let(:menuitems) { [menuitem1, menuitem2] }

      describe '#click' do
        let(:response) { double('Response') }
        it 'sends click action' do
          expect(widget_controller).to receive(:send_action).and_return(response)
          expect(subject.click(menuitem2)).to equal(response)
        end
      end

      describe '#items' do
        let(:response) do
          double('Response', { body: [{ items: [{ label: menuitem1 }, { label: menuitem2 }] }] })
        end
        it 'lists items' do
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.items).to match_array(menuitems)
        end
      end
    end
  end
end
