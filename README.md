# LibyuiClient

# CI

Ruby gem to interact with YaST applications via libyui-rest-api.
See documentation of the [libyui-rest-api project](https://github.com/libyui/libyui-rest-api/)
for more details about server side implementation.

Usage example:

```ruby
require 'libyui_client'

app = LibyuiClient::App.new(host: 'localhost', port: '9999')
button = app.button(id: 'settime')
button.click
```

## Installing libyui_client

As soon as the gem is in development, run the following command from command line:

```
gem "libyui_client", :git => "git@github.com:jknphy/libyui_client.git"
```

Now need to require gem in order to use it.

## Initialize the app under control

It is assumed the application is running on `localhost:9999`.
Then the code to initialize the application looks like:

```ruby
require 'libyui_client'

app = LibyuiClient::App.new(host: 'localhost', port: '9999')
```

## Supported widgets

libyui_client supports different types of widgets.

Here are examples of usage:

### Button
```ruby
app.button(id: 'test_id').click  # clicks the button with id 'test_id'
app.button(label: 'test_label').debug_label # get 'debug_label' value with label 'test_label'
```

### Bargraph
```ruby
# Get list of labels in the segments:
app.bargraph(class: YBarGraph).labels
# Get array of hashes containing label->value pairs denoting each segment:
app.bargraph(class: YBarGraph).segments
# Get list of values in the segments:
app.bargraph(class: YBarGraph).values
```

### Checkbox
```ruby
app.checkbox(id: 'test_id').check  # checks the checkbox with id 'test_id'
app.checkbox(label: 'test_label', class: 'YCheckBox').checked? # gets the state of checkbox with label 'test_label'
app.checkbox(id: 'test_id').toggle # toggles the checkbox with id 'test_id'
app.checkbox(label: 'test_label', class: 'YCheckBoxFrame').uncheck  # unchecks the checkbox with id 'test_id'
```

### Combobox
```ruby
app.combobox(id: 'test_id').items  # gets all available items for combobox with id 'test_id'
app.combobox(id: 'test_id').select  # selects the checkbox with id 'test_id'
app.combobox(id: 'test_id').selected_item # gets the selected item in combobox with id 'test_id'
app.combobox(label: 'cmbx', class: 'YComboBox').set # Sets custom string to the editable checkbox
```

### Datefield
```ruby
# Set date field to 2048-08-16
app.datefield(class: 'YDateField').set(Date.new(2048, 8, 16))
app.datefield(id: 'date').value  # gets value from datefield with id 'date'
```

### Label
```ruby
app.label(id: 'test_id').heading?  # gets if label has bold font respresentation with id 'test_id'
app.label(id: 'test_id').text  # gets text from label with id 'test_id'
```

### Menubutton
```ruby
app.menubutton(id: 'test_id').click('button1')  # clicks on 'button1' of menubutton with id 'test_id'
```

### Numberbox
```ruby
app.numberbox(id: 'test_id').min_value  # gets min value to be set in numberbox with id 'test_id'
app.numberbox(id: 'test_id').max_value  # gets max value to be set in numberbox with id 'test_id'
app.numberbox(id: 'test_id').set(99)  # sets 99 to numberbox with id 'test_id'
app.numberbox(id: 'test_id').value  # gets value from numberbox with id 'test_id'
```

### Radiobutton
```ruby
app.radiobutton(id: 'test_id').select  # selects the radiobutton with id 'test_id'
app.radiobutton(id: 'test_id').selected?  # gets the state of radiobutton with id 'test_id'
```

### Richtext
```ruby
app.richtext(id: 'test_id').click_link('test_link')  # clicks on link "test_link" with id 'test_id'
app.richtext(id: 'test_id').text  # gets text from richtext
```

### Tab
```ruby
app.tab(id: 'test_id').items  # gets items from tab with id 'test_id'
app.tab(id: 'test_id').select(value: 'item')  # selects specific tab with id 'test_id'
app.tab(id: 'test_id').selected_item  # gets selected tab for tab with id 'test_id'
```

### Table
```ruby
# checks if there is not rows in table with id 'test_id':
app.table(id: 'test_id').empty?
# gets rows in the table with id 'test_id':
app.table(id: 'test_id').items
# selects row in table with value test.item.1 and column test.header:
app.table(id: 'test_id').select( value: 'test.item.1', column: 'test.header' )
# selects row with number 3, numeration starts from 0 and corresponds to the order
# in the list returned by method `items`:
app.table(id: 'test_id').select(row: 3)
# gets items currently selected in table with id 'test_id':
app.table(id: 'test_id').seleted_items


```
### Textbox
```ruby
app.textbox(id: 'test_id').max_length
app.textbox(id: 'test_id').set('Test Text')  # sets "Test Text" to textbox with id 'test_id'
app.textbox(id: 'test_id').password? # checks password mode for textbox with id 'test_id'
app.textbox(id: 'test_id').valid_chars # checks valid chars for textbox with id 'test_id'
app.textbox(id: 'test_id').value  # gets value from textbox with id 'test_id'
```

### TimeField
```ruby
# Set TimeField to current time
app.timefield(label: 'time', class: 'YTimeField').set(Time.now)
app.timefield(id: 'time').value  # gets value from timefield with id 'time'
```

### Tree
```ruby
app.tree(id: 'test_id').items  # gets items from tree with id 'test_id'
app.tree(id: 'test_id').select('node1|node1_2')  # selects item in tree with id 'test_id'
app.tree(id: 'test_id').selected_item  # gets currently highlighted item from tree with id 'test_id'
```

## Filters

libyui_client supports the same filters, as libyui-rest-api provides:

  * id - widget ID serialized as string, might include special characters like backtick (\`)
  * label - widget label as currently displayed (i.e. translated!)
  * class - widget class

Also, regex for the filters is allowed.

Example:
```ruby
app.button(id: /.*test/).debug_label
```

## Waits

### Default timeout and interval

All the actions against widgets in libyui_client are made with default timeout and interval.
Default timeout is 5 sec, default interval is 0.5 sec.
That means libyui_client will repeat sending requests to YaST application every 0.5 seconds until 5 seconds
timeout will be reached. This default wait is needed because widgets may not be loaded immediately while trying to
interact with them (e.g. when navigating from one screen to another).

The default timeout and interval can be changed by the following:

```ruby
LibyuiClient.timeout = 10
LibyuiClient.interval = 1
```

### Specific waits

All the widgets include Waitable module, which contains special methods to allow explicit waiting:
`wait_until` and `wait_while`.
These methods can be used when it is needed to wait until some property of the widget will be changed.

For example, wait until button will be enabled and click on it:

```ruby
# with #to_proc syntax:
app.button(id: 'test_id').wait_until(&:enabled?).click

# without #to_proc syntax:
app.button(id: 'test_id').wait_until{ |button| button.enabled? }.click
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
