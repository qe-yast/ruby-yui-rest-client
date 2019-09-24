# frozen_string_literal: true

require 'libyui_client/version'
require 'libyui_client/widget_controller'
require 'libyui_client/process_helper'
require 'libyui_client/widget'
require 'libyui_client/rest_api_client'

# Client to interact with YAST UI rest api framework for integration testing
module LibyuiClient
  
  WIDGET_TYPE = {
    'YQWizardButton' => Button,
    'YPushButton' => Button,
    'YInputField' => TextBox,
    'YTable' => Table,
    'YWizard' => Wizard,
    'YDialog' => Dialog,
    'YCheckBox' => CheckBox,
    'YComboBox' => ComboBox,
    'YRadioButton' => RadioButton
  }.freeze

  def self.find_widget(id: nil, label: nil, type: nil, 
                       debug_label: nil, inner_type: nil,
                       timeout: 0)
    raise "Use id, label or type to filter a widget" if [id, label, type].none?
    json = nil
    timed_retry(timeout) do
      params = {}
      params[:id] = id if id
      params[:label] = label if label
      params[:type] = type if type
      json = send_request(:get, '/widgets', params).first
      if debug_label
        json['debug_label'] == debug_label
      elsif inner_type
        json['type'] == inner_type
      else
        json
      end
    end
    json_class = json["class"]
    app_class = WIDGET_TYPE.fetch(json_class) { 
        raise "#{json_class} does not map to any application control" }
    app_class.new(json)
  end
  
  # TODO: use aruba
  def self.run_command(command:, timeout: 0)
    timed_retry(timeout) do
      system(command)
    end
  end
end
