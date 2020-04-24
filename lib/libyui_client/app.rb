# frozen_string_literal: true

module LibyuiClient
  class App
    # Used to initialize main entry point of LibyuiClient and set host and port
    # for the application under control.
    # @param host [String] host address (e.g. 'localhost', '192.168.0.1')
    # @param port [String] port opened for communication (e.g. '9999')
    def initialize(host:, port:)
      @host = host
      @port = port
      @widget_controller = Http::WidgetController.new(host: host, port: port)
    end

    # Initializes new instance of Button with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Button] new instance of Button
    # @example
    #   app.button(id: 'id', label: 'label', type: 'YPushButton')
    def button(filter)
      Widgets::Button.new(@widget_controller, Validate.filter(filter))
    end

    # Initializes new instance of Checkbox with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Checkbox] new instance of Checkbox
    # @example
    #   app.checkbox(id: 'id', label: 'label', type: 'YCheckBox')
    def checkbox(filter)
      Widgets::Checkbox.new(@widget_controller, Validate.filter(filter))
    end

    # Initializes new instance of Combobox with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Combobox] new instance of Combobox
    # @example
    #   app.checkbox(id: 'id', label: 'label', type: 'YComboBox')
    def combobox(filter)
      Widgets::Combobox.new(@widget_controller, Validate.filter(filter))
    end

    # Initializes new instance of Radiobutton with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Radiobutton] new instance of Radiobutton
    # @example
    #   app.checkbox(id: 'id', label: 'label', type: 'YRadioButton')
    def radiobutton(filter)
      Widgets::Radiobutton.new(@widget_controller, Validate.filter(filter))
    end

    # Initializes new instance of Table with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Table] new instance of Table
    # @example
    #   app.checkbox(id: 'id', label: 'label', type: 'YTable')
    def table(filter)
      Widgets::Table.new(@widget_controller, Validate.filter(filter))
    end

    # Initializes new instance of Textbox with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Textbox] new instance of Textbox
    # @example
    #   app.checkbox(id: 'id', label: 'label', type: 'YInputField')
    def textbox(filter)
      Widgets::Textbox.new(@widget_controller, Validate.filter(filter))
    end
  end
end
