# frozen_string_literal: true

module LibyuiClient

  def self.find_widgets(id: nil, label: nil, type: nil)
    params = {}
    params[:id] = id if id
    params[:label] = label if label
    params[:type] = type if type

    send_request(:get, '/widgets', params)
  end

  def self.find_widget(type: nil, label: nil, id: nil)
    find_widgets(type: type, label: label, id: id).first
  end

  def self.change_widget(action: nil, type: nil, label: nil, id: nil, value: nil)
    params = {}
    params[:action] = action if action
    params[:id] = id if id
    params[:label] = label if label
    params[:type] = type if type
    params[:value] = value if value

    send_request(:post, '/widgets', params)
  end
end
