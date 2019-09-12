# frozen_string_literal: true

# Class representing a button in the UI
class Button
  attr_reader :class, :debug_label, :id, :label

  def initialize(json = nil)
    raise 'Error initializing Button with nil data' if json.nil?
    unless %w[YPushButton YQWizardButton].include? json['class']
      raise "Error initializing Button with #{json['class']}"
    end

    @class = json['class']
    @debug_label = json['debug_label']
    @id = json['id']
    @label = json['label']
  end

  def click
    LibyuiClient.change_widget(action: 'press', id: @id)
  end
end

# Class representing a textbox in the UI
class TextBox
  attr_reader :class, :debug_label, :id, :label,
              :password_mode, :valid_chars, :value

  def initialize(json = nil)
    raise 'Error initializing widget with nil data' if json.nil?
    if json['class'] != 'YInputField'
      raise "Error initializing YInputField with #{json['class']}"
    end

    @class = json['class']
    @debug_label = json['debug_label']
    @id = json['id']
    @label = json['label']
    @password_mode = json['password_mode']
    @valid_chars = json['valid_chars']
    @value = json['value']
  end

  def type(value: '')
    LibyuiClient.change_widget(action: 'enter_text', id: @id, value: value)
    LibyuiClient.find_widget_by_id(id: @id, class_name: TextBox)
  end
end

# Class representing a table in the UI
class Table
  attr_reader :class, :has_multi_selection, :header, :id, :items_count

  def initialize(json = nil)
    raise 'Error initializing widget with nil data' if json.nil?
    if json['class'] != 'YTable'
      raise "Error initializing YTable with #{json['class']}"
    end

    @class = json['class']
    @has_multi_selection = json['hasMultiSelection']
    @header = json['header']
    @id = json['id']
    @items = json['items']
    @items_count = json['items_count']
  end

  def search_row(options = {})
    header_indexes = options.keys.collect { |h| @header.index(h.to_s) }
    # TODO: check for valid key values
    # raise "Table does not contain header #{key}"
    # unless @header.include? key.to_s
    @items.each do |row|
      found = true
      options.values.zip(header_indexes).each do |value, index|
        found &&= (row['labels'][index] == value)
      end
      return row['labels'] if found
    end
    []
  end
end

# Class representing a Wizard in the UI
class Wizard
  attr_reader :class, :debug_label, :id

  def initialize(json = nil)
    raise 'Error initializing Wizard with nil data' if json.nil?
    if json['class'] != 'YWizard'
      raise "Error initializing Wizard with #{json['class']}"
    end

    @class = json['class']
    @debug_label = json['debug_label']
    @id = json['id']
  end
end

# Class representing a Popup in the UI
class Popup
  attr_reader :class, :type

  def initialize(json = nil)
    raise 'Error initializing widget with nil data' if json.nil?
    if json['class'] != 'YDialog'
      raise "Error initializing Popup with #{json['class']}"
    end

    @class = json['class']
    @type = json['type']
  end
end

# Class representing a Checkbox in the UI
class CheckBox
  attr_reader :class, :debug_label, :id, :label, :value

  def initialize(json = nil)
    raise 'Error initializing widget with nil data' if json.nil?
    if json['class'] != 'YCheckBox'
      raise "Error initializing YCheckBox with #{json['class']}"
    end

    @class = json['class']
    @debug_label = json['debug_label']
    @id = json['id']
    @label = json['label']
    @value = json['value']
  end

  def toggle
    LibyuiClient.change_widget(action: 'toggle', id: @id)
    LibyuiClient.find_widget_by_id(id: @id, class_name: CheckBox)
  end
end

# Class representing a ComboBox in the UI
class ComboBox
  attr_reader :class, :debug_label, :id, :label, :value

  def initialize(json = nil)
    raise 'Error initializing widget with nil data' if json.nil?
    if json['class'] != 'YComboBox'
      raise "Error initializing YComboBox with #{json['class']}"
    end

    @class = json['class']
    @debug_label = json['debug_label']
    @id = json['id']
    @value = json['value']
  end

  def select(value)
    LibyuiClient.change_widget(action: 'select_combo', id: @id, value: value)
    LibyuiClient.find_widget_by_id(id: @id, class_name: ComboBox)
  end
end

# Class representing a RadioButton in the UI
class RadioButton
  attr_reader :class, :debug_label, :id, :label, :value

  def initialize(json = nil)
    raise 'Error: trying to initialize widget with nil data' if json.nil?
    if json['class'] != 'YRadioButton'
      raise "Error initializing YRadioButton with #{json['class']}"
    end

    @class = json['class']
    @debug_label = json['debug_label']
    @id = json['id']
    @value = json['value']
  end

  def select
    LibyuiClient.change_widget(action: 'switch_radio', id: @id, value: value)
    LibyuiClient.find_widget_by_id(id: @id, class_name: RadioButton)
  end
end
