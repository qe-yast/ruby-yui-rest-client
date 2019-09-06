require "libyui_client/version"
require "libyui_client/widget_controller"
require "libyui_client/process_helper"
 
module LibyuiClient
 def self.prepare_action(action, id, label)
   params = { action: action }
   params[:label] = label unless label.empty?
   params[:id] = id unless id.empty?

	 params
 end
  
 def self.click_button(id: "", label: "")
   #params = prepare_action("press_button", type, name)
   params = prepare_action("press", id, label)
   change_widget(params)
 end
  
# def self.switch_radio(name:, type: "")
#   params = prepare_action("switch_radio", type, name)
#   change_widget(params)
# end
#  
# def self.type_text(name:, type: "")
#   params = prepare_action("enter_text", type, name)
#   change_widget(params)
# end
#  
# def self.select_combo(name:, type: "")
#   params = prepare_action("select_combo", type, name)
#   change_widget(params)
# end
  
 WIDGET_TYPE = {
   "checkbox" => "YCheckBox",
   "label" => "YLabel",
   "radiobutton" => "YRadioButton",
   "pushbutton" => "YPushButton",
   "button" => "YPushButton",
 }
  
 def self.find_element(by, type, value, timeout)
   timed_retry(timeout) do
     widgets = find_widgets(type: type)
  
     if by == "id"
       widgets.select { |w| w["id"] == id }
     elsif by == "label"
       widgets.select { |w| w["debug_label"] == label || w["label"] == label }
     end
  
     widgets.all?{|w| w["value"] == value}
   end
 end
  
 def self.find_element_by_id(id, type, timeout)
   find_element(by: "id", type: type, value: id, timeout: timeout)
 end
  
 def self.find_element_by_label(label, type, timeout)
   find_element(by: "label", type: type, value: label, timeout: timeout)
 end
  
 def self.check_dialog_heading(timeout: 0)
   label = ""
   timed_retry(timeout) do
     dialog_type = find_widget(type: "YDialog")["type"]
  
     label = if dialog_type == "wizard"
       find_widget(type: "YWizard")["debug_label"]
     else
       # non-wizard windows (ncurses) use "Heading" widget
       find_widget(type: "YLabel_Heading")["label"]
     end
  
     # remove the shortcut markers, they are assigned dynamically
     !label.nil? && label != "untitled YQWizard"
   end
   label.tr("&", "")
 end
  
 def self.is_popup_displayed(timeout: 0)
   timed_retry(timeout) do
     find_widget(type: "YDialog")["type"] == "popup"
   end
 end
end
