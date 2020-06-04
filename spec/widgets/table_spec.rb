# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Table do
      include_context 'WidgetsCommon'

      # Request/Response parts
      let(:table_header) { { body: '[{ "header": ["header1","header2"]}]' } }
      let(:query_value_column) { { value: 'test_row', column: '0' } }
      let(:query_select_row) { { action: 'select' }.merge(query_value_column) }
      let(:query_select) { { query: id.merge(query_select_row) } }

      # Stubbed Requests
      let(:get_header_table) { stub_get_id.to_return(table_header) }
      let(:select_row_in_existing_table) { stub_post.with(query_select) }
      let(:select_row_in_non_existent_table) { stub_post_404.with(query_select) }
      let(:request_query_value_column) { { value: 'test_row', column: 'header1' } }

      describe '#select' do
        context 'existing widget' do
          it 'should succeed' do
            get_header_table
            select_row_in_existing_table
            @app.table(id).select(request_query_value_column)
            expect(select_row_in_existing_table).to have_been_made.once
          end
        end
        context 'non-existent widget' do
          it 'should raise WidgetNotFoundError' do
            get_header_table
            select_row_in_non_existent_table
            expect { @app.table(id).select(request_query_value_column) }.to raise_error(Error::WidgetNotFoundError)
          end
        end
      end
    end
  end
end
