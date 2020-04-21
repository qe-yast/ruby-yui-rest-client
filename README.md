# LibyuiClient

Ruby gem to interact with YaST applications via libyui-rest-api.

Usage example:

```ruby
require 'libyui_client'

app = LibyuiClient::App.new
app.connect(host: 'localhost', port: '9999')

button = app.button(id: 'settime').click
```

## Installing libyui_client

As soon as the gem is in development, run the following command from command line:
```
gem "libyui_client", :git => "git@github.com:jknphy/libyui_client.git"
```

Now need to require gem in order to use it.

## Connect to the running app

It is assumed the application is running on `localhost:9999`.
Then the code to connect to the application looks like:

```ruby
require 'libyui_client'

app = LibyuiClient::App.new
app.connect(host: 'localhost', port: '9999')
```

## Supported widgets

libyui_client supports different types of widgets.

Here are examples of usage:

### Button

```ruby
app = LibyuiClient::App.new.connect(host: 'localhost', port: '9999')
app.button(id: 'test_id').click  # clicks the button with id 'test_id'
app.button(label: 'test_label', id: 'test_id').debug_label # get 'debug_label' value
```

### Checkbox

```ruby
app = LibyuiClient::App.new.connect(host: 'localhost', port: '9999')
app.checkbox(id: 'test_id').check  # checks the checkbox with id 'test_id'
app.checkbox(id: 'test_id').uncheck  # unchecks the checkbox with id 'test_id'
app.checkbox(id: 'test_id').toggle # toggles the checkbox with id 'test_id'
app.checkbox(label: 'test_label', id: 'test_id').checked? # gets the state of checkbox
```

### Combobox

```ruby
app = LibyuiClient::App.new.connect(host: 'localhost', port: '9999')
app.combobox(id: 'test_id').select  # selects the checkbox with id 'test_id'
app.combobox(id: 'test_id').items  # gets all available items for combobox with id 'test_id'
app.combobox(id: 'test_id').selected_item # gets the selected item
```

### Radiobutton

```ruby
app = LibyuiClient::App.new.connect(host: 'localhost', port: '9999')
app.radiobutton(id: 'test_id').select  # selects the radiobutton with id 'test_id'
app.radiobutton(id: 'test_id').selected?  # gets the state of radiobutton
```

### Table

```ruby
app = LibyuiClient::App.new.connect(host: 'localhost', port: '9999')
app.table(id: 'test_table').select_row(value: 'test.item.1', column_id: 0)  # selects the row in table with test.item.1
```

### Textbox

```ruby
app = LibyuiClient::App.new.connect(host: 'localhost', port: '9999')
app.textbox(id: 'test_id').set('Test Text')  # sets "Test Text" to textbox with id 'test_id'
app.textbox(id: 'test_id').value  # gets value from textbox
```

## Filters

libyui_client supports the same filters, as libyui-rest-api provides:

  * id - widget ID serialized as string, might include special characters like backtick (\`)
  * label - widget label as currently displayed (i.e. translated!)
  * type - widget class

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
