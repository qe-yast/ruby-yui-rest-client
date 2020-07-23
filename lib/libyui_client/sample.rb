require 'libyui_client'

# app = LibyuiClient::App.new(host: ENV['GUEST_IP'] , port: '9999')
app = LibyuiClient::App.new(host: 'localhost' , port: '9998')
button = app.button(id: 'add')
button.click
