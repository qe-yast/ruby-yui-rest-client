# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  RSpec.describe App do
    let(:app) { App.new(host: 'test.org', port: 80) }
    describe '#client_api_version' do
      context 'client REST API version is requested' do
        it 'returns the version defined in LibyuiClient' do
          expect(app.client_api_version).to eq(LibyuiClient::API_VERSION)
        end
      end
    end
    describe '#server_api_version' do
      context 'server provides server version normally' do
        it 'returns server side REST API version' do
          allow_any_instance_of(Http::VersionController).to receive(:api_version).and_return('v1')
          expect(app.server_api_version).to eq('v1')
        end
      end
    end
    describe '#check_api_version' do
      context 'server API version is same as client' do
        it 'return true' do
          allow_any_instance_of(Http::VersionController).to receive(:api_version).and_return(API_VERSION)
          expect(app.check_api_version).to be_truthy
        end
      end
      context 'server API version is older than client' do
        it 'returns true' do
          allow_any_instance_of(Http::VersionController).to receive(:api_version).and_return('v0.1')
          expect(app.check_api_version).to be_truthy
        end
      end
      context 'server API version is higher than client' do
        it 'returns false' do
          allow_any_instance_of(Http::VersionController).to receive(:api_version).and_return('v10.7')
          expect(app.check_api_version).to be_falsy
        end
      end
      context 'server API version is not property provided and is nill' do
        it 'raises LibyuiClientError' do
          allow_any_instance_of(Http::VersionController).to receive(:api_version).and_return(nil)
          expect { app.check_api_version }.to raise_error(Error::LibyuiClientError)
        end
      end
    end
  end
end
