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
      @version_controller = Http::VersionController.new(host: host, port: port)
    end

    # Initializes new instance of Bargraph with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Bargraph] new instance of Table
    # @example
    #   app.bargraph(id: 'id', label: 'label', class: 'YBarGraph')
    def bargraph(filter)
      Widgets::Bargraph.new(@widget_controller, FilterExtractor.new(filter))
    end

    # Initializes new instance of Button with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Button] new instance of Button
    # @example
    #   app.button(id: 'id', label: 'label', class: 'YPushButton')
    def button(filter)
      Widgets::Button.new(@widget_controller, FilterExtractor.new(filter))
    end

    # Initializes new instance of Checkbox with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Checkbox] new instance of Checkbox
    # @example
    #   app.checkbox(id: 'id', label: 'label', class: 'YCheckBox')
    def checkbox(filter)
      Widgets::Checkbox.new(@widget_controller, FilterExtractor.new(filter))
    end

    # Initializes new instance of Combobox with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Combobox] new instance of Combobox
    # @example
    #   app.combobox(id: 'id', label: 'label', class: 'YComboBox')
    def combobox(filter)
      Widgets::Combobox.new(@widget_controller, FilterExtractor.new(filter))
    end

    # Initializes new instance of Datefield with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Datefield] new instance of Datefield
    # @example
    #   app.datefield(id: 'id', label: 'label', class: 'YDateField')
    def datefield(filter)
      Widgets::Datefield.new(@widget_controller, FilterExtractor.new(filter))
    end

    # Initializes new instance of Label with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Label] new instance of Label
    # @example
    #   app.label(id: 'id', label: 'label', class: 'YLabel')
    def label(filter)
      Widgets::Label.new(@widget_controller, FilterExtractor.new(filter))
    end

    # Initializes new instance of Menubutton with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Menubutton] new instance of Menubutton
    # @example
    #   app.menubutton(id: 'id', label: 'label', class: 'YMenuButton')
    def menubutton(filter)
      Widgets::Menubutton.new(@widget_controller, FilterExtractor.new(filter))
    end

    # Initializes new instance of Multilinebox with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Multilinebox] new instance of Multilinebox
    # @example
    #   app.multilinebox(id: 'id', label: 'label', class: 'YMultiLineEdit')
    def multilinebox(filter)
      Widgets::Multilinebox.new(@widget_controller, FilterExtractor.new(filter))
    end

    # Initializes new instance of Numberbox with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Numberbox] new instance of Numberbox
    # @example
    #   app.numberbox(id: 'id', label: 'label', class: 'YIntField')
    def numberbox(filter)
      Widgets::Numberbox.new(@widget_controller, FilterExtractor.new(filter))
    end

    # Initializes new instance of Progressbar with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Progressbar] new instance of Progressbar
    # @example
    #   app.progressbar(id: 'id', label: 'label', class: 'YProgressBar')
    def progressbar(filter)
      Widgets::Progressbar.new(@widget_controller, FilterExtractor.new(filter))
    end

    # Initializes new instance of Radiobutton with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Radiobutton] new instance of Radiobutton
    # @example
    #   app.radiobutton(id: 'id', label: 'label', class: 'YRadioButton')
    def radiobutton(filter)
      Widgets::Radiobutton.new(@widget_controller, FilterExtractor.new(filter))
    end

    # Initializes new instance of Richtext with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Richtext] new instance of Richtext
    # @example
    #   app.richtext(id: 'id', label: 'label', class: 'YRichText')
    def richtext(filter)
      Widgets::Richtext.new(@widget_controller, FilterExtractor.new(filter))
    end

    # Initializes new instance of Selectionbox with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Selectionbox] new instance of Selectionbox
    # @example
    #   app.selectionbox(id: 'id', label: 'label', class: 'YSelectionBox')
    def selectionbox(filter)
      Widgets::Selectionbox.new(@widget_controller, FilterExtractor.new(filter))
    end

    # Initializes new instance of Tab with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Tab] new instance of Tab
    # @example
    #   app.tab(id: 'id', label: 'label', class: 'YDumbTab')
    def tab(filter)
      Widgets::Tab.new(@widget_controller, FilterExtractor.new(filter))
    end

    # Initializes new instance of Table with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Table] new instance of Table
    # @example
    #   app.table(id: 'id', label: 'label', class: 'YTable')
    def table(filter)
      Widgets::Table.new(@widget_controller, FilterExtractor.new(filter))
    end

    # Initializes new instance of time field with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Timefield] new instance of Table
    # @example
    #   app.timefield(id: 'id', label: 'label', class: 'YTimeField')
    def timefield(filter)
      Widgets::Timefield.new(@widget_controller, FilterExtractor.new(filter))
    end

    # Initializes new instance of Textbox with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Textbox] new instance of Textbox
    # @example
    #   app.textbox(id: 'id', label: 'label', class: 'YInputField')
    def textbox(filter)
      Widgets::Textbox.new(@widget_controller, FilterExtractor.new(filter))
    end

    # Initializes new instance of Tree with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Tree] new instance of Tree
    # @example
    #   app.tree(id: 'id', label: 'label', class: 'YTree')
    def tree(filter)
      Widgets::Tree.new(@widget_controller, FilterExtractor.new(filter))
    end

    # Initializes new instance of Wizard with the filter provided.
    # Does not make request to libyui-rest-api.
    # @param filter [Hash] filter to find a widget
    # @return [Widgets::Wizard] new instance of Wizard
    # @example
    #   app.wizard(id: 'id', label: 'label', class: 'YWizard')
    def wizard(filter)
      Widgets::Wizard.new(@widget_controller, FilterExtractor.new(filter))
    end

    # Returns client side libyui REST API version
    # @return libyui client REST API version
    def client_api_version
      API_VERSION
    end

    # Returns server side libyui REST API version
    # @return libyui server REST API version
    def server_api_version
      @version_controller.api_version
    end

    # Validates if server side REST API is compatible with client inside
    # @return true if version is compatible, false if not or any error while
    #         receiving version from the server
    def check_api_version
      LibyuiClient.logger.info("Client API version: #{API_VERSION}")
      server_api_v = server_api_version
      raise Error::LibyuiClientError if server_api_v.nil?

      LibyuiClient.logger.info("Server API version: #{server_api_v}")
      server_api_v <= client_api_version
    end
  end
end
