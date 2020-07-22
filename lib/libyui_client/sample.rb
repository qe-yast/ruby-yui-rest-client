require 'libyui_client'

# app = LibyuiClient::App.new(host: ENV['GUEST_IP'] , port: '9999')
app = LibyuiClient::App.new(host: '10.0.2.2' , port: '5555')
button = app.button(id: 'add')
button.click
