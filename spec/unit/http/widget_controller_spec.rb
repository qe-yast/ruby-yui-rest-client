# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Http
    RSpec.describe WidgetController do
      let(:http) { double('http', { code: 200, is_a?: true, body: '{ "id": "foo" }' }) }
      let(:httpclient) { instance_double(HttpClient) }
      before { allow(Net::HTTP).to receive(:get_response).and_return http }

      describe '#find' do
        context 'GET request contains valid filter' do
          it 'returns a new LibyuiClient::Http::Response' do
            allow(http).to receive(:request).with(an_instance_of(Net::HTTP::Get)).and_return(Net::HTTPResponse)
            allow(Net::HTTPResponse).to receive(:body).and_return(http)
            allow(httpclient).to receive(:compose_uri)
            allow(httpclient).to receive(:http_get)

            widget_controller = WidgetController.new(host: 'test.org', port: 9999)
            response = widget_controller.find({ id: 'foo' }, timeout: 5, interval: 0.5)
            expect(response).to be_instance_of(Response)
            expect(response.body).to include(id: 'foo')
          end
        end
      end

      describe '#send_action' do
        context 'POST request with filter' do
          it 'returns a new LibyuiClient::Http::Response' do
            allow(http).to receive(:request).with(an_instance_of(Net::HTTP::Post)).and_return(Net::HTTPResponse)
            allow(Net::HTTPResponse).to receive(:body).and_return(http)
            allow(httpclient).to receive(:compose_uri)
            allow(httpclient).to receive(:http_post)
            widget_controller = WidgetController.new(host: 'test.org', port: 9999)
            response = widget_controller.find({ id: 'foo' }, timeout: 5, interval: 0.5)
            expect(response).to be_instance_of(Response)
            expect(response.body).to include(id: 'foo')
          end
        end
      end
    end
  end
end
