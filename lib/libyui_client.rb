# frozen_string_literal: true

require 'libyui_client/version'
require 'libyui_client/widget_controller'
require 'libyui_client/process_helper'
require 'libyui_client/widget'
require 'libyui_client/rest_api_client'

module LibyuiClient
  WIDGET_TYPE = {
    "Popup" => "YDialog",
   }

  def self.find_widget_by_id(id:, class_name:, timeout: 0)
    widget = nil
    timed_retry(timeout) do
      widget = find_widget(id: id)
    end
    result = class_name.new(widget)
  end

  def self.find_widget_by_type(class_name:, timeout: 0)
    widget = nil
    timed_retry(timeout) do
      widget = find_widget(type: WIDGET_TYPE[class_name.to_s])
    end
    result = class_name.new(widget)
  end

  # def self.switch_radio(name:, type: "")
  #   params = prepare_action("switch_radio", type, name)
  #   change_widget(params)
  # end
  #

  # def self.select_combo(name:, type: "")
  #   params = prepare_action("select_combo", type, name)
  #   change_widget(params)
  # end

  # WIDGET_TYPE = {
  #   "checkbox" => "YCheckBox",
  #   "label" => "YLabel",
  #   "radiobutton" => "YRadioButton",
  #   "pushbutton" => "YPushButton",
  #   "button" => "YPushButton",
  # }
  #
  
  # TODO: use aruba
  def self.run_command(command:, timeout: 0)
    timed_retry(timeout) do
      system(command)
    end
  end
end
