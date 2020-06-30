# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Menubutton do
      let(:widget_controller) { instance_double('widget_controller') }
      let(:filter) { FilterExtractor.new({ id: 'foo' }) }
      subject { Menubutton.new(widget_controller, filter) }
      let(:button1) { 'button1' }
      let(:button2) { 'button2' }
      let(:buttons) { [button1, button2] }

      describe '#click' do
        let(:response) { double('Response') }
        it 'sends click action' do
          expect(widget_controller).to receive(:send_action).and_return(response)
          expect(subject.click(button2)).to equal(response)
        end
      end

      describe '#items' do
        let(:response) do
          double('Response', { body: [{ items: [{ label: button1 }, { label: button2 }] }] })
        end
        it 'lists items' do
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.items).to match_array(buttons)
        end
      end
    end
  end
end
