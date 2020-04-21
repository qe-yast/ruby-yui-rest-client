# frozen_string_literal: true

module LibyuiClient
  class App
    attr_reader :host, :port

    def initialize
      @http_client = Http::LibyuiHttpClient.new(self)
    end

    # Used to specify the host and port for the application where all requests will be sent.
    # @param host [String] host address (e.g. 'localhost', '192.168.0.1')
    # @param port [String] port opened for communication (e.g. '9999')
    # @return [App]
    def connect(host:, port:)
      @host = host
      @port = port
      self
    end

    # Initializes new instance of Button with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Button] new instance of Button
    # @example
    #   app.button(id: 'id', label: 'label', type: 'YPushButton')
    def button(filter)
      Widgets::Button.new(@http_client, Validate.filter(filter))
    end

    # Initializes new instance of Checkbox with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Checkbox] new instance of Checkbox
    # @example
    #   app.checkbox(id: 'id', label: 'label', type: 'YCheckBox')
    def checkbox(filter)
      Widgets::Checkbox.new(@http_client, Validate.filter(filter))
    end

    # Initializes new instance of Combobox with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Combobox] new instance of Combobox
    # @example
    #   app.checkbox(id: 'id', label: 'label', type: 'YComboBox')
    def combobox(filter)
      Widgets::Combobox.new(@http_client, Validate.filter(filter))
    end

    # Initializes new instance of Radiobutton with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Radiobutton] new instance of Radiobutton
    # @example
    #   app.checkbox(id: 'id', label: 'label', type: 'YRadioButton')
    def radiobutton(filter)
      Widgets::Radiobutton.new(@http_client, Validate.filter(filter))
    end

    # Initializes new instance of Table with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Table] new instance of Table
    # @example
    #   app.checkbox(id: 'id', label: 'label', type: 'YTable')
    def table(filter)
      Widgets::Table.new(@http_client, Validate.filter(filter))
    end

    # Initializes new instance of Textbox with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Textbox] new instance of Textbox
    # @example
    #   app.checkbox(id: 'id', label: 'label', type: 'YInputField')
    def textbox(filter)
      Widgets::Textbox.new(@http_client, Validate.filter(filter))
    end
  end
end
