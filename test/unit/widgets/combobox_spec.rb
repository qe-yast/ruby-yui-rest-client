# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Combobox do
      let(:widget_controller) { instance_double('widget_controller') }
      let(:widget_filter) { FilterExtractor.new({ id: 'test_combo' }) }
      subject { Combobox.new(widget_controller, widget_filter) }
      describe '#select' do
        it 'has a request with action select and correct value' do
          allow(widget_controller).to receive(:send_action)
          expect(subject).to receive(:action).with({ action: 'select', value: 'Any (Highest Available)' })
          expect(subject.select('Any (Highest Available)')).to be_instance_of(Combobox)
        end
      end

      describe '#items' do
        it 'can return list of the combos of the widget' do
          response = double('Response', { body: [{ 'class': 'YCombobox',
                                                   columns: 1,
                                                   id: 'test_combo',
                                                   items: [{ label: 'Any (Highest Available)',
                                                             selected: true },
                                                           { label: 'Force NFSv3' }],
                                                   items_count: 2 }] })
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.items).to eq(['Any (Highest Available)', 'Force NFSv3'])
        end
      end

      describe '#value' do
        it 'returns the selected combo item' do
          response = double('Response', { body: [{ 'class': 'YCombobox',
                                                   columns: 1,
                                                   id: 'test_combo',
                                                   items: [{ label: 'Any (Highest Available)',
                                                             selected: true },
                                                           { label: 'Force NFSv3' }],
                                                   items_count: 2,
                                                   value: 'Any (Highest Available)' }] })
          expect(widget_controller).to receive(:find).and_return(response)
          expect(subject.value).to eq('Any (Highest Available)')
        end
      end

      describe '#items' do
        it 'can return list of the combos of the widget' do
          response = double('Response', { body: [{ 'class': 'YCombobox',
                                                   columns: 1,
                                                   id: 'test_combo',
                                                   items: [{ label: 'Any (Highest Available)',
                                                             selected: true },
                                                           { label: 'Force NFSv3' }],
                                                   items_count: 2 }] })
          allow(widget_controller).to receive(:find).and_return(response)
          expect(subject.items).to eq(['Any (Highest Available)', 'Force NFSv3'])
        end
      end

      describe '#editable?' do
        context 'combobox has editable property set to true' do
          it 'returns true' do
            response = double('Response', { body: [{ 'class': 'YCombobox',
                                                     id: 'test_combo',
                                                     editable: true }] })
            allow(widget_controller).to receive(:find).and_return(response)
            expect(subject.editable?).to be_truthy
          end
        end
        context 'combobox has editable property set to false explicitly' do
          it 'returns false' do
            response = double('Response', { body: [{ 'class': 'YCombobox',
                                                     id: 'test_combo',
                                                     editable: false }] })
            allow(widget_controller).to receive(:find).and_return(response)
            expect(subject.editable?).to be_falsy
          end
        end
        context 'combobox editable property is not set' do
          it 'returns false' do
            response = double('Response', { body: [{ 'class': 'YCombobox',
                                                     id: 'test_combo' }] })
            allow(widget_controller).to receive(:find).and_return(response)
            expect(subject.editable?).to be_falsy
          end
        end
      end

      describe '#set' do
        it 'calls enter_text action on the combobox' do
          expect(widget_controller).to receive(:send_action).with({ id: 'test_combo' },
                                                                  { action: 'enter_text', value: 'CustomItem' })
          expect(subject.set('CustomItem')).to equal(subject)
        end
      end
    end
  end
end
