# frozen_string_literal: true

require 'rspec'

RSpec.describe LibyuiClient::Widgets::Button do
  before(:all) do
    LibyuiClient.timeout = 1
    LibyuiClient.interval = 0.2
    @app = LibyuiClient::App.new.connect(host: 'www.example.com', port: '9999')
  end

  after do
    # Do nothing
  end

  let(:widgets_url) { 'http://www.example.com:9999/v1/widgets' }
  let(:query_press) { { query: {id: 'test', action: 'press' } } }
  let(:query_get) { { query: {id: 'test' } } }
  let(:status404) { {status: 404} }
  let(:body_enabled) do
    json = '[{
    "class": "YQWizardButton",
    "debug_label": "Cancel",
    "fkey": 9,
    "id": "cancel",
    "label": "&Cancel"
  }]'
    {body: json}
  end
  let(:body_disabled) { {body: '[{"enabled": "false"}]'} }

  let(:success_press) { stub_request(:post, widgets_url).with(query_press) }
  let(:not_found_press) { stub_request(:post, widgets_url).with(query_press).to_return(status404) }
  let(:success_get_enabled) { stub_request(:get, widgets_url).with(query_get).to_return(body_enabled) }
  let(:success_get_disabled) { stub_request(:get, widgets_url).with(query_get).to_return(body_disabled) }
  let(:not_found_get) { stub_request(:get, widgets_url).with(query_get).to_return(status404) }

  describe '#click' do
    context 'existing widget' do
      it 'should succeed' do
        success_press
        @app.button(id: 'test').click
        expect(success_press).to have_been_made.once
      end
    end
    context 'non-existent widget' do
      it 'should raise WidgetNotFoundError' do
        not_found_press
        expect { @app.button(id: 'test').click }.to raise_error(LibyuiClient::Error::WidgetNotFoundError)
      end
    end
  end

  describe '#debug_label' do
    context 'existing widget' do
      it 'should return String' do
        success_get_enabled
        expect(@app.button(id: 'test').debug_label).to eq('Cancel')
      end
    end
    context 'non-existent widget' do
      it 'should raise WidgetNotFoundError' do
        not_found_get
        expect { @app.button(id: 'test').debug_label }.to raise_error(LibyuiClient::Error::WidgetNotFoundError)
      end
    end
  end

  describe '#enabled?' do
    context 'existing widget' do
      context 'is enabled' do
        it 'should return true' do
          success_get_enabled
          expect(@app.button(id: 'test').enabled?).to eq(true)
        end
      end
      context 'is disabled' do
        it 'should return false' do
          success_get_disabled
          expect(@app.button(id: 'test').enabled?).to eq(false)
        end
      end
    end
    context 'non-existent widget' do
      it 'should raise WidgetNotFoundError' do
        not_found_get
        expect { @app.button(id: 'test').enabled? }.to raise_error(LibyuiClient::Error::WidgetNotFoundError)
      end
    end
  end
  describe '#fkey' do
    context 'existing widget' do
      it 'should return Integer' do
        success_get_enabled
        expect(@app.button(id: 'test').fkey).to eq(4)
      end
    end
    context 'non-existent widget' do
      it 'should raise WidgetNotFoundError' do
        not_found_get
        expect { @app.button(id: 'test').fkey }.to raise_error(LibyuiClient::Error::WidgetNotFoundError)
      end
    end
  end
end
