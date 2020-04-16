# frozen_string_literal: true

require 'rspec'

RSpec.shared_context 'WidgetsContext' do
  before(:all) do
    LibyuiClient.timeout = 0
    LibyuiClient.interval = 0
    @app = LibyuiClient::App.new.connect(host: 'www.example.com', port: '9999')
  end

  # Common Request/Response parts
  let(:widgets_url) { 'http://www.example.com:9999/v1/widgets' }
  let(:id) { { id: 'libyui' } }
  let(:query_id) { { query: id } }
  let(:status404) { { status: 404 } }
  let(:disabled_widget) { { body: '[{"enabled": "false"}]' } }

  # Common Stubbed Requests
  # POST Stubs
  let(:stub_post) { stub_request(:post, widgets_url) }
  let(:stub_post_404) { stub_post.to_return(status404) }

  # GET Stubs
  let(:stub_get) { stub_request(:get, widgets_url) }
  let(:stub_get_id) { stub_get.with(query_id) }
  let(:stub_get_id_404) { stub_get_id.to_return(status404) }
end
