# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Http
    RSpec.describe HttpClient do
      let(:http) { Net::HTTPSuccess.new('1.1', 200, 'OK') }
      before { allow(http).to receive(:body).and_return('{"id": "foo"}') }
      describe '#http_get' do
        context 'makes a GET request' do
          it 'returns a new LibyuiClient::Http::Response' do
            expect_any_instance_of(Net::HTTP).to receive(:request).with(an_instance_of(Net::HTTP::Get))
                                                                  .and_return(http)
            escapedurl = URI.escape('http://test.org')
            uri = URI.parse(escapedurl)
            response = HttpClient.http_get(uri)
            expect(response.code).to eq(200)
            expect(response).to have_attributes(code: 200, body: '{"id": "foo"}')
            expect(response.body).to eq('{"id": "foo"}')
          end
        end
      end

      describe '#http_post' do
        context 'makes a POST request' do
          it 'returns a new LibyuiClient::Http::Response' do
            expect_any_instance_of(Net::HTTP).to receive(:request).with(an_instance_of(Net::HTTP::Post))
                                                                  .and_return(http)
            escapedurl = URI.escape('http://test.org/?widgets')
            uri = URI.parse(escapedurl)
            response = HttpClient.http_post(uri)
            expect(response.code).to eq(200)
            expect(response.body).to eq('{"id": "foo"}')
          end
        end
      end

      describe '#compose_uri' do
        context 'when different port is defined' do
          it 'returns the correct port' do
            expected_port = 9999
            actual_url = HttpClient.compose_uri('test.org', expected_port, '/widgets', {})
            aggregate_failures "failures when actual is #{actual_url}" do
              expect(actual_url).to be_instance_of(URI::HTTP)
              expect(actual_url.port).to eq(expected_port)
            end
          end
        end
        context 'when request does not contain filter parameter' do
          it 'returns url without filter' do
            expected_url = 'http://test.org/widgets?'
            actual_url = HttpClient.compose_uri('test.org', 80, '/widgets', {})
            aggregate_failures "failures when actual is #{actual_url}" do
              expect(actual_url).to be_instance_of(URI::HTTP)
              expect(actual_url.to_s).to eq(expected_url)
            end
          end
        end
        context 'when request has filter parameter' do
          it 'returns url with filter' do
            expected_url = 'http://test.org/widgets?id=foo'
            actual_url = HttpClient.compose_uri('test.org', 80, '/widgets', { id: 'foo' })
            aggregate_failures "failures when actual is #{actual_url}" do
              expect(actual_url).to be_instance_of(URI::HTTP)
              expect(actual_url.to_s).to eq(expected_url)
            end
          end
        end
        context 'when request contain filter parameter with action' do
          it 'returns url with filter and action' do
            expected_url = 'http://test.org/widgets?id=foo&action=PRESS'
            actual_url = HttpClient.compose_uri('test.org', 80, '/widgets', { id: 'foo', action: 'PRESS' })
            aggregate_failures "failures when actual is #{actual_url}" do
              expect(actual_url).to be_instance_of(URI::HTTP)
              expect(actual_url.to_s).to eq(expected_url)
            end
          end
        end
        context 'when url has protocol' do
          it 'raises InvalidComponentError' do
            expect { HttpClient.compose_uri('http://test.org', 80, 'widgets', { id: 'foo' }) }
              .to raise_error(URI::InvalidComponentError)
          end
        end
        context 'when filter do not have /' do
          it 'rasise InvalidComponentError' do
            expect { HttpClient.compose_uri('test.org', 80, 'widgets', { id: 'foo' }) }
              .to raise_error(URI::InvalidComponentError)
          end
        end
      end
    end
  end
end
