# frozen_string_literal: true

require 'rspec'

HOSTNAME = 'www.example.com'
PORT = 9999
URL = "http://#{HOSTNAME}:#{PORT}"

RSpec.shared_context 'WidgetsCommon' do
  before(:all) do
    YuiRestClient.timeout = 0
    YuiRestClient.interval = 0
    @app = YuiRestClient::App.new(host: HOSTNAME, port: PORT)
  end

  # Common Request/Response parts
  let(:widgets_url) { "#{URL}/#{YuiRestClient::API_VERSION}/widgets" }
  let(:id) { { id: 'libyui' } }
  let(:query_id) { { query: id } }
  let(:status404) { { status: 404 } }
  let(:disabled_widget) { { body: '[{"enabled": "false"}]' } }

  # Common Stubbed Requests
  # POST Stubs
  let(:stub_post) { stub_request(:post, widgets_url) }
  let(:stub_post404) { stub_post.to_return(status404) }

  # GET Stubs
  let(:stub_get) { stub_request(:get, widgets_url) }
  let(:stub_get_id) { stub_get.with(query_id) }
  let(:stub_get_id404) { stub_get_id.to_return(status404) }
end
