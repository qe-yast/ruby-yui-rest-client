# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Dialog do
      include_context 'WidgetsCommon'

      # Request/Response parts
      let(:type) { 'popup' }
      let(:type_from_dialog) { { body: "[{\"type\":\"#{type}\"}]" } }

      # Stubbed Requests
      let(:get_type) { stub_get_id.to_return(type_from_dialog) }

      describe '#type' do
        context 'existing widget' do
          it 'should return String' do
            get_type
            expect(@app.dialog(id).type).to eq(type)
          end
        end
        context 'non-existent widget' do
          it 'should raise WidgetNotFoundError' do
            stub_get_id_404
            expect { @app.dialog(id).type }.to raise_error(Error::WidgetNotFoundError)
          end
        end
      end
    end
  end
end
