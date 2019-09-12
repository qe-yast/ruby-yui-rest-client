
class Button 
  attr_reader :class, :debug_label, :id, :label
    
  def initialize(json = nil)
    raise "Error: trying to initialize Button with nil data" if json.nil?
    if !["YPushButton", "YQWizardButton"].include? json["class"]
      raise "Error: trying to initialize Button object with #{json["class"]}"
    end
    @class = json["class"]
    @debug_label = json["debug_label"]
    @id = json["id"]
    @label = json["label"]
  end
  
  def click
    LibyuiClient.change_widget({ action: 'press', id: @id })
  end
end

class TextBox 
  attr_reader :class, :debug_label, :id, :label, :password_mode, :valid_chars, :value
    
  def initialize(json = nil)
    raise "Error: trying to initialize widget with nil data" if json.nil?
    if json["class"] != "YInputField"
      raise "Error: trying to initialize YInputField object with #{json["class"]}"
    end
    @class = json["class"]
    @debug_label = json["debug_label"]
    @id = json["id"]
    @label = json["label"]
    @password_mode = json["password_mode"]
    @valid_chars = json["valid_chars"]
    @value = json["value"]
  end
  
  def type(value: "")
    LibyuiClient.change_widget({ action: 'enter_text', id: @id, value: value })
    LibyuiClient.find_widget_by_id(id: @id, class_name: TextBox)
  end
end

class Table 
  attr_reader :class, :has_multi_selection, :header, :id, :items_count
    
  def initialize(json = nil)
    raise "Error: trying to initialize widget with nil data" if json.nil?
    if json["class"] != "YTable"
      raise "Error: trying to initialize YTable object with #{json["class"]}"
    end
    @class = json["class"]
    @has_multi_selection = json["hasMultiSelection"]
    @header = json["header"]
    @id = json["id"]
    @items = json["items"]
    @items_count = json["items_count"]
  end

  def search_row(options = {})
    header_indexes = options.keys.collect { |h| @header.index(h.to_s) }
    #raise "Table does not contain header #{key}" unless @header.include? key.to_s
    @items.each do |row|
      found = true
      options.values.zip(header_indexes).each do |value, index|
        found = found && (row["labels"][index] == value)
      end
      return row["labels"] if found
    end
    return []
  end
end

class Wizard 
  attr_reader :class, :debug_label, :id 
    
  def initialize(json = nil)
    raise "Error: trying to initialize Wizard with nil data" if json.nil?
    if json["class"] != "YWizard"
      raise "Error: trying to initialize Wizard object with #{json["class"]}"
    end
    @class = json["class"]
    @debug_label = json["debug_label"]
    @id = json["id"]
  end
end

class Popup 
  attr_reader :class, :type
    
  def initialize(json = nil)
    raise "Error: trying to initialize widget with nil data" if json.nil?
    if json["class"] != "YDialog"
      raise "Error: trying to initialize Popup object with #{json["class"]}"
    end
    @class = json["class"]
    @type = json["type"]
  end
end
