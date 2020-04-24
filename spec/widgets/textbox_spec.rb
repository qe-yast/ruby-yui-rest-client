# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Textbox do
      include_context 'WidgetsCommon'

      # Request/Response parts
      let(:value) { 'test_value' }
      let(:query_enter_text) { { query: id.merge(action: 'enter_text', value: value) } }
      let(:text_from_textbox) { { body: "[{\"value\":\"#{value}\"}]" } }

      # Stubbed Requests
      let(:set_text_existing_textbox) { stub_post.with(query_enter_text) }
      let(:set_text_non_existent_textbox) { stub_post_404.with(query_enter_text) }
      let(:get_value) { stub_get_id.to_return(text_from_textbox) }

      describe '#set' do
        context 'existing widget' do
          it 'should succeed' do
            set_text_existing_textbox
            @app.textbox(id).set(value)
            expect(set_text_existing_textbox).to have_been_made.once
          end
        end
        context 'non-existent widget' do
          it 'should raise WidgetNotFoundError' do
            set_text_non_existent_textbox
            expect { @app.textbox(id).set(value) }.to raise_error(Error::WidgetNotFoundError)
          end
        end
      end

      describe '#value' do
        context 'existing widget' do
          it 'should return String' do
            get_value
            expect(@app.textbox(id).value).to eq(value)
          end
        end
        context 'non-existent widget' do
          it 'should raise WidgetNotFoundError' do
            stub_get_id_404
            expect { @app.textbox(id).value }.to raise_error(Error::WidgetNotFoundError)
          end
        end
      end
    end
  end
end
