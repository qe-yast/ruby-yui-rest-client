# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Http
    RSpec.describe Response do
      describe '#body' do
        context 'when regex filter is used' do
          it 'returns filtered response' do
            res = double(body: '[{"id": "foo_id", "label": "foo_label"}, {"id": "bar_id", "label": "bar_label"}]')
            response = Response.new(res)
            filtered_body = response.body(regex_filter: { id: /bar.*/ })
            expect(filtered_body.first[:id]).to eq('bar_id')
          end
        end
      end
    end
  end
end
