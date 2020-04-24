# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Button do
      include_context 'WidgetsCommon'

      # Request/Response parts
      let(:query_id_press) { { query: id.merge(action: 'press') } }
      let(:button_enabled) { { body: '[{"debug_label": "Cancel","fkey": 9}]' } }

      # Stubbed Requests
      let(:press_existing_button) { stub_post.with(query_id_press) }
      let(:press_non_existent_button) { stub_post_404.with(query_id_press) }
      let(:get_enabled_button) { stub_get_id.to_return(button_enabled) }
      let(:get_disabled_button) { stub_get_id.to_return(disabled_widget) }

      describe '#click' do
        context 'existing widget' do
          it 'should succeed' do
            press_existing_button
            @app.button(id).click
            expect(press_existing_button).to have_been_made.once
          end
        end
        context 'non-existent widget' do
          it 'should raise WidgetNotFoundError' do
            press_non_existent_button
            expect { @app.button(id).click }.to raise_error(Error::WidgetNotFoundError)
          end
        end
      end

      describe '#debug_label' do
        context 'existing widget' do
          it 'should return String' do
            get_enabled_button
            expect(@app.button(id).debug_label).to eq('Cancel')
          end
        end
        context 'non-existent widget' do
          it 'should raise WidgetNotFoundError' do
            stub_get_id_404
            expect { @app.button(id).debug_label }.to raise_error(Error::WidgetNotFoundError)
          end
        end
      end

      describe '#enabled?' do
        context 'existing widget' do
          context 'is enabled' do
            it 'should return true' do
              get_enabled_button
              expect(@app.button(id).enabled?).to eq(true)
            end
          end
          context 'is disabled' do
            it 'should return false' do
              get_disabled_button
              expect(@app.button(id).enabled?).to eq(false)
            end
          end
        end
        context 'non-existent widget' do
          it 'should raise WidgetNotFoundError' do
            stub_get_id_404
            expect { @app.button(id).enabled? }.to raise_error(Error::WidgetNotFoundError)
          end
        end
      end
      describe '#fkey' do
        context 'existing widget' do
          it 'should return Integer' do
            get_enabled_button
            expect(@app.button(id).fkey).to eq(9)
          end
        end
        context 'non-existent widget' do
          it 'should raise WidgetNotFoundError' do
            stub_get_id_404
            expect { @app.button(id).fkey }.to raise_error(Error::WidgetNotFoundError)
          end
        end
      end
    end
  end
end
