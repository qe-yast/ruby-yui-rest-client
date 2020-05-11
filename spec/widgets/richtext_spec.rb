# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Richtext do
      include_context 'WidgetsCommon'

      # Request/Response parts
      let(:link) { 'href' }
      let(:query_select) { { query: id.merge(action: 'press', value: link) } }
      let(:text) { 'text label' }
      let(:text_from_label) { { body: "[{\"text\":\"#{text}\"}]" } }

      # Stubbed Requests
      let(:click_link_in_existing_richtext) { stub_post.with(query_select) }
      let(:click_link_in_non_existing_richtext) { stub_post_404.with(query_select) }
      let(:get_text) { stub_get_id.to_return(text_from_label) }

      describe '#click_link' do
        context 'existing widget' do
          it 'should succeed' do
            click_link_in_existing_richtext
            @app.richtext(id).click_link(link)
            expect(click_link_in_existing_richtext).to have_been_made.once
          end
        end
        context 'non-existent widget' do
          it 'should raise WidgetNotFoundError' do
            click_link_in_non_existing_richtext
            expect { @app.richtext(id).click_link(link) }.to raise_error(Error::WidgetNotFoundError)
          end
        end
      end

      describe '#text' do
        context 'existing widget' do
          it 'should return String' do
            get_text
            expect(@app.richtext(id).text).to eq(text)
          end
        end
        context 'non-existent widget' do
          it 'should raise WidgetNotFoundError' do
            stub_get_id_404
            expect { @app.richtext(id).text }.to raise_error(Error::WidgetNotFoundError)
          end
        end
      end
    end
  end
end
