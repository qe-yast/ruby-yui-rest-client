# frozen_string_literal: true

# Client to interact with YAST UI rest api framework for integration testing
module LibyuiClient
  def self.change_widget(action: nil, id: nil, type: nil, label: nil,
                        value: nil, column: nil)
    params = {}
    params[:action] = action if action
    params[:id] = id if id
    params[:label] = label if label
    params[:type] = type if type
    params[:value] = value if value
    params[:column] = column if column

    send_request(:post, '/widgets', params)
  end
end
