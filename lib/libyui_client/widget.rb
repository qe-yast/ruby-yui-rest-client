# frozen_string_literal: true

require 'rainbow'

# Class representing a button in the UI
class Button
  attr_reader :class, :debug_label, :id, :label

  def initialize(json = nil)
    @class = json['class']
    @debug_label = json['debug_label']
    @id = json['id']
    @label = json['label'].tr("&", "")
  end

  def click
    LibyuiClient.change_widget(action: 'press', id: @id)
    puts Rainbow("\tclicks '#{@label}' Button").blue
  end
end

# Class representing a textbox in the UI
class TextBox
  attr_reader :class, :debug_label, :id, :label,
              :password_mode, :valid_chars, :value

  def initialize(json = nil)
    @class = json['class']
    @debug_label = json['debug_label']
    @id = json['id']
    @label = json['label'].tr("&", "")
    @password_mode = json['password_mode']
    @valid_chars = json['valid_chars']
    @value = json['value']
  end

  def type(value)
    LibyuiClient.change_widget(action: 'enter_text', id: @id, value: value)
    puts Rainbow("\ttypes '#{value}' on '#{@label}' TextBox").blue
    LibyuiClient.find_widget(id: @id)
  end
end

# Class representing a table in the UI
class Table
  attr_reader :class, :has_multi_selection, :header, :id

  def initialize(json = nil)
    @class = json['class']
    @has_multi_selection = json['hasMultiSelection']
    @header = json['header']
    @id = json['id']
  end

  def select_row(value:, column: nil)
    myvar = LibyuiClient.change_widget(action: 'select', id: @id,
                               value: value, column: column)
    #TODO: check for error when implemented in libyui-rest-api
    puts Rainbow("\tselects row #1 with value '#{value}' in table '#{@id}'").blue
  end
  
   # Very complicated method that is not needed because rest api will
   # provides column param
#  def search_row(options = {})
#    header_indexes = options.keys.collect { |h| @header.index(h.to_s) }
#    # TODO: check for valid key values
#    # raise "Table does not contain header #{key}"
#    # unless @header.include? key.to_s
#    @items.each do |row|
#      found = true
#      options.values.zip(header_indexes).each do |value, index|
#        found &&= (row['labels'][index] == value)
#      end
#      return row['labels'] if found
#    end
#    []
#  end
end

# Class representing a Wizard in the UI
class Wizard
  attr_reader :class, :debug_label, :id

  def initialize(json = nil)
    @class = json['class']
    @debug_label = json['debug_label']
    @id = json['id']
    puts Rainbow("\tdisplays '#{@debug_label}' Wizard").blue
  end
end

# Class representing a Popup in the UI
class Dialog
  attr_reader :class, :type

  def initialize(json = nil)
    @class = json['class']
    @type = json['type']
    puts Rainbow("\tdisplays '#{@type}' Dialog").blue
  end
end

# Class representing a Checkbox in the UI
class CheckBox
  attr_reader :class, :debug_label, :id, :label, :value

  def initialize(json = nil)
    @class = json['class']
    @debug_label = json['debug_label']
    @id = json['id']
    @label = json['label'].tr("&", "")
    @value = json['value']
  end

  def toggle
    LibyuiClient.change_widget(action: 'toggle', id: @id)
    puts Rainbow("\ttoggles #{@label} CheckBox").blue
    LibyuiClient.find_widget(id: @id)
  end
end

# Class representing a ComboBox in the UI
class ComboBox
  attr_reader :class, :debug_label, :id, :label, :value

  def initialize(json = nil)
    @class = json['class']
    @debug_label = json['debug_label']
    @id = json['id']
    @label = json['label'].tr("&", "")
    @value = json['value']
  end

  def select(value)
    LibyuiClient.change_widget(action: 'select_combo', id: @id, value: value)
    puts Rainbow("\tselects '#{value}' on '#{@label}' ComboBox").blue
    LibyuiClient.find_widget(id: @id)
  end
end

# Class representing a RadioButton in the UI
class RadioButton
  attr_reader :class, :debug_label, :id, :label, :value

  def initialize(json = nil)
    @class = json['class']
    @debug_label = json['debug_label']
    @id = json['id']
    @label = json['label'].tr("&", "")
    @value = json['value']
  end

  def select
    LibyuiClient.change_widget(action: 'switch_radio', id: @id, value: value)
    puts Rainbow("\tswitches '#{@label}' RadioButton").blue
    LibyuiClient.find_widget(id: @id)
  end
end

