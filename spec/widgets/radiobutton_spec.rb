# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Radiobutton do
      include_context 'WidgetsCommon'

      # Request/Response parts
      let(:query_select) { { query: id.merge(action: 'select') } }
      let(:selected_radiobutton) { { body: '[{"value":true}]' } }
      let(:deselected_radiobutton) { { body: '[{"value":false}]' } }

      # Stubbed Requests
      let(:select_existing_radiobutton) { stub_post.with(query_select) }
      let(:select_non_existent_radiobutton) { stub_post_404.with(query_select) }
      let(:get_selected_radiobutton) { stub_get_id.to_return(selected_radiobutton) }
      let(:get_deselected_radiobutton) { stub_get_id.to_return(deselected_radiobutton) }

      describe '#select' do
        context 'existing widget' do
          it 'should succeed' do
            select_existing_radiobutton
            @app.radiobutton(id).select
            expect(select_existing_radiobutton).to have_been_made.once
          end
        end
        context 'non-existent widget' do
          it 'should raise WidgetNotFoundError' do
            select_non_existent_radiobutton
            expect { @app.radiobutton(id).select }.to raise_error(Error::WidgetNotFoundError)
          end
        end
      end

      describe '#selected?' do
        context 'existing widget' do
          context 'selected radiobutton' do
            it 'should return true' do
              get_selected_radiobutton
              expect(@app.radiobutton(id).selected?).to eq(true)
            end
          end
          context 'deselected radiobutton' do
            it 'should return false' do
              get_deselected_radiobutton
              expect(@app.radiobutton(id).selected?).to eq(false)
            end
          end
        end
        context 'non-existent widget' do
          it 'should raise WidgetNotFoundError' do
            stub_get_id_404
            expect { @app.radiobutton(id).selected? }.to raise_error(Error::WidgetNotFoundError)
          end
        end
      end
    end
  end
end
