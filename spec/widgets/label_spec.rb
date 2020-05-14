# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Label do
      include_context 'WidgetsCommon'

      # Request/Response parts
      let(:text) { 'text label' }
      let(:text_from_label) { { body: "[{\"text\":\"#{text}\"}]" } }
      let(:heading_bold_font_from_label) { { body: '[{"is_heading":true}]' } }
      let(:heading_no_bold_font_from_label) { { body: '[{}]' } }

      # Stubbed Requests
      let(:get_text) { stub_get_id.to_return(text_from_label) }
      let(:get_heading_when_bold_font) { stub_get_id.to_return(heading_bold_font_from_label) }
      let(:get_heading_when_no_bold_font) { stub_get_id.to_return(heading_no_bold_font_from_label) }

      describe '#text' do
        context 'existing widget' do
          it 'should return String' do
            get_text
            expect(@app.label(id).text).to eq(text)
          end
        end
        context 'non-existent widget' do
          it 'should raise WidgetNotFoundError' do
            stub_get_id_404
            expect { @app.label(id).text }.to raise_error(Error::WidgetNotFoundError)
          end
        end
      end

      describe '#heading?' do
        context 'existing widget' do
          context 'when bold font' do
            it 'should return true' do
              get_heading_when_bold_font
              expect(@app.label(id).heading?).to eq(true)
            end
          end
          context 'without bold font' do
            it 'should return false' do
              get_heading_when_no_bold_font
              expect(@app.label(id).heading?).to eq(false)
            end
          end
        end
        context 'non-existent widget' do
          it 'should raise WidgetNotFoundError' do
            stub_get_id_404
            expect { @app.label(id).heading? }.to raise_error(Error::WidgetNotFoundError)
          end
        end
      end
    end
  end
end
