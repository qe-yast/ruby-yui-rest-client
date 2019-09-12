# frozen_string_literal: true

require 'libyui_client/version'
require 'libyui_client/widget_controller'
require 'libyui_client/process_helper'
require 'libyui_client/widget'
require 'libyui_client/rest_api_client'

# Client to interact with YAST UI rest api framework for integration testing
module LibyuiClient
  WIDGET_TYPE = {
    'Popup' => 'YDialog'
  }.freeze

  def self.find_widget_by_id(id:, class_name:, timeout: 0)
    widget = nil
    id.tr('\"', '')
    timed_retry(timeout) do
      widget = find_widget(id: id)
    end
    class_name.new(widget)
  end

  def self.find_widget_by_id_label(id:, label:, class_name:, timeout: 0)
    widget = nil
    timed_retry(timeout) do
      widget = find_widget(id: id)
      widget['debug_label'] == label
    end
    class_name.new(widget)
  end

  def self.find_widget_by_type(class_name:, timeout: 0)
    widget = nil
    timed_retry(timeout) do
      widget = find_widget(type: WIDGET_TYPE[class_name.to_s])
    end
    class_name.new(widget)
  end

  # TODO: use aruba
  def self.run_command(command:, timeout: 0)
    timed_retry(timeout) do
      system(command)
    end
  end
end
