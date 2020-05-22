# # frozen_string_literal: true

# module LibyuiClient
#   module Widgets
#     module Behaviors
#       module Valueable
#         # Gets value from 'value' parameter in JSON representation of widget.
#         # @return [String] value
#         # @example Get value from textbox with id "address"
#         #   {
#         #       "class": "YInputField",
#         #       "debug_label": "Address",
#         #       "hstretch": true,
#         #       "id": "address",
#         #       "label": "A&ddress",
#         #       "password_mode": false,
#         #       "value": "Test Address"
#         #   }
#         # @example
#         #   app.textbox(id: 'address').value # Test Address
#         def value
#           property(:value)
#         end
#       end
#     end
#   end
# end
