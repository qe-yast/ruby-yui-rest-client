# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Shared behaviours for widgets
    # require 'libyui_client/widgets/behaviors/item_pressable'
    # require 'libyui_client/widgets/behaviors/item_selectable' 
    # require 'libyui_client/widgets/behaviors/pressable'
    # require 'libyui_client/widgets/behaviors/settable'
    # require 'libyui_client/widgets/behaviors/valueable'

    require 'libyui_client/action_controller'
    require 'libyui_client/waitable'

    # Widgets with specific implementation
    require 'libyui_client/widgets/widget'
    require 'libyui_client/widgets/button'
    require 'libyui_client/widgets/checkbox'
    require 'libyui_client/widgets/combobox'
    require 'libyui_client/widgets/label'
    require 'libyui_client/widgets/menubutton'
    require 'libyui_client/widgets/numberbox'
    require 'libyui_client/widgets/radiobutton'
    require 'libyui_client/widgets/tab'
    require 'libyui_client/widgets/table'
    require 'libyui_client/widgets/textbox'
    require 'libyui_client/widgets/richtext'
    require 'libyui_client/widgets/tree'

    require 'libyui_client/widgets/item_controller'

    # Widgets without any specialization yet

    # Class representing a Wizard UI. It can be YWizard
    class Wizard < Widgets::Widget
    end
  end
end
