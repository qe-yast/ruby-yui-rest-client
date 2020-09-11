# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Multilinebox do
      let(:widget_controller) { instance_double('widget_controller') }
      let(:filter) { FilterExtractor.new({ id: 'test_multiline' }) }
      subject { Multilinebox.new(widget_controller, filter) }

      describe '#max_length' do
        let(:response) { double('Response', { body: [{ input_max_length: -1 }] }) }
        it 'returns input max length' do
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.max_length).to eq(-1)
        end
      end

      describe '#visible_lines' do
        let(:response) { double('Response', { body: [{ default_visible_lines: 3 }] }) }
        it 'returns number of default visible lines' do
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.visible_lines).to eq(3)
        end
      end

      describe '#set' do
        it 'sets text' do
          expect(widget_controller).to receive(:send_action)
          expect(subject.set("text\ntext in new line")).to equal(subject)
        end
      end

      describe '#value' do
        let(:response) { double('Response', { body: [{ value: "text\ntext in new line" }] }) }
        it 'should return the text of the :value' do
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.value).to eq("text\ntext in new line")
        end
      end
    end
  end
end
