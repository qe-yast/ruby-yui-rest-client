# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Combobox do
      include_context 'WidgetsCommon'

      # Request/Response parts
      let(:select_item) { 'Africa' }
      let(:query_select) { { query: id.merge(action: 'select', value: select_item) } }
      let(:items_body) do
        { body: '[{"value": "Africa", "items": [{"label": "Africa","selected": true},{"label": "Argentina"}]}]' }
      end
      let(:items_list) { %w[Africa Argentina] }

      # Stubbed Requests
      let(:select_item_in_existing_combobox) { stub_post.with(query_select) }
      let(:select_item_in_non_existent_combobox) { stub_post_404.with(query_select) }
      let(:get_items) { stub_get_id.to_return(items_body) }

      describe '#select' do
        context 'existing widget' do
          it 'should succeed' do
            select_item_in_existing_combobox
            @app.combobox(id).select(select_item)
            expect(select_item_in_existing_combobox).to have_been_made.once
          end
        end
        context 'non-existent widget' do
          it 'should raise WidgetNotFoundError' do
            select_item_in_non_existent_combobox
            expect { @app.combobox(id).select(select_item) }.to raise_error(Error::WidgetNotFoundError)
          end
        end
      end

      describe '#items' do
        context 'existing widget' do
          it 'should return array of strings' do
            get_items
            expect(@app.combobox(id).items).to eq(items_list)
          end
        end
        context 'non-existent widget' do
          it 'should raise WidgetNotFoundError' do
            stub_get_id_404
            expect { @app.combobox(id).items }.to raise_error(Error::WidgetNotFoundError)
          end
        end
      end

      describe '#value' do
        context 'existing widget' do
          it 'should return array of strings' do
            get_items
            expect(@app.combobox(id).value).to eq(select_item)
          end
        end
        context 'non-existent widget' do
          it 'should raise WidgetNotFoundError' do
            stub_get_id_404
            expect { @app.combobox(id).value }.to raise_error(Error::WidgetNotFoundError)
          end
        end
      end

      describe '#select' do
        context 'existing widget' do
          it 'should succeed' do
            select_item_in_existing_combobox
            @app.combobox(id).select(select_item)
            expect(select_item_in_existing_combobox).to have_been_made.once
          end
        end
        context 'non-existent widget' do
          it 'should raise WidgetNotFoundError' do
            select_item_in_non_existent_combobox
            expect { @app.combobox(id).select(select_item) }.to raise_error(Error::WidgetNotFoundError)
          end
        end
      end
    end
  end
end
