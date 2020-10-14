# frozen_string_literal: true

require 'rspec'

module YuiRestClient
  module Http
    RSpec.describe VersionController do
      let(:version_controller) { VersionController.new(host: 'test.org', port: 80) }
      describe '#api_version' do
        context 'server operates normally and provides api version' do
          it 'returns server side API VERSION' do
            stub_request(:get, 'test.org/version').to_return(status: 200, body: '{"api_version" : "v1"}')
            expect(version_controller.api_version).to eq('v1')
          end
        end
        context 'server returns not OK status' do
          it 'raises YuiRestClientError' do
            stub_request(:get, 'test.org/version').to_return(status: [500, 'Internal Server Error'])
            expect { version_controller.api_version }.to raise_error(Error::YuiRestClientError)
          end
        end
        context 'server response times out' do
          it 'raises TimeoutError' do
            stub_request(:get, 'test.org/version').to_timeout
            expect { version_controller.api_version }.to raise_error(Timeout::Error)
          end
        end
      end
    end
  end
end
