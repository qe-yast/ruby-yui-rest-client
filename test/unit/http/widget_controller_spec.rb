# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Http
    RSpec.describe WidgetController do
      describe '.WidgetController' do
        context 'when be initialized with default timeout and interval' do
          it 'has default timeout and interval' do
            @obj = WidgetController.new(host: 'localhost', port: 9999)
            aggregate_failures 'for .WidgetController' do
              expect(@obj).to be_instance_of(WidgetController)
              expect(@obj.instance_eval('@timeout', __FILE__, __LINE__)).to equal(5)
              expect(@obj.instance_eval('@interval', __FILE__, __LINE__)).to equal(0.5)
            end
          end
        end
        context 'when be initialized with custom timeout' do
          it 'uses new timeout' do
            LibyuiClient.timeout = 2
            @obj = WidgetController.new(host: 'localhost', port: 9999)
            aggregate_failures 'for .WidgetController' do
              expect(@obj).to be_instance_of(WidgetController)
              expect(@obj.instance_eval('@timeout', __FILE__, __LINE__)).to equal(2)
              expect(@obj.instance_eval('@interval', __FILE__, __LINE__)).to equal(0.5)
            end
            LibyuiClient.timeout = 5
          end
        end
        context 'when be initialized with custom interval' do
          it 'uses new interval and still uses default timeout' do
            LibyuiClient.interval = 2
            @obj = WidgetController.new(host: 'localhost', port: 9999)
            aggregate_failures 'for .WidgetController' do
              expect(@obj).to be_instance_of(WidgetController)
              expect(@obj.instance_eval('@timeout', __FILE__, __LINE__)).to equal(5)
              expect(@obj.instance_eval('@interval', __FILE__, __LINE__)).to equal(2)
            end
          end
        end
      end

      describe '#find' do
        context 'GET request contains valid filter' do
          it 'returns a new LibyuiClient::Http::Response' do
            stub_request(:get, 'test.org/v1/widgets?id=foo').to_return(status: 200, body: '{ "id": "foo" }')
            widget_controller = WidgetController.new(host: 'test.org', port: 80)
            response = widget_controller.find({ id: 'foo' })
            expect(response).to be_instance_of(Response)
            expect(response.body).to include(id: 'foo')
          end
        end
      end

      describe '#send_action' do
        context 'POST request with filter' do
          it 'returns a new LibyuiClient::Http::Response' do
            stub_request(:get, 'test.org/v1/widgets?id=foo').to_return(status: 200, body: '{ "id": "foo" }')
            stub_request(:post, 'test.org/v1/widgets?id=foo').to_return(status: 200)
            widget_controller = WidgetController.new(host: 'test.org', port: 80)
            response = widget_controller.find({ id: 'foo' })
            expect(response).to be_instance_of(Response)
            expect(response.body).to include(id: 'foo')
          end
        end
      end
    end
  end
end
