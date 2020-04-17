# frozen_string_literal: true

module LibyuiClient
  class App
    attr_reader :host, :port

    def initialize
      @http_client = Http::LibyuiHttpClient.new(self)
    end

    def connect(host:, port:)
      @host = host
      @port = port
      self
    end

    def button(filter)
      Widgets::Button.new(@http_client, Validate.filter(filter))
    end

    def checkbox(filter)
      Widgets::Checkbox.new(@http_client, Validate.filter(filter))
    end

    def combobox(filter)
      Widgets::Combobox.new(@http_client, Validate.filter(filter))
    end

    def radiobutton(filter)
      Widgets::Radiobutton.new(@http_client, Validate.filter(filter))
    end

    def table(filter)
      Widgets::Table.new(@http_client, Validate.filter(filter))
    end

    def textbox(filter)
      Widgets::Textbox.new(@http_client, Validate.filter(filter))
    end
  end
end
