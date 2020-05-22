# frozen_string_literal: true

require 'libyui_client'

app = LibyuiClient::App.new(host: 'localhost', port: '9998')

table = app.table(id: '"unselected"')
# table.select(value: '/dev/vdd', column: 'Device')
puts
puts table.items_selected


# items = table.items(selected_only: true)
# puts items.class
# puts items

# textbox = app.textbox(id: '"Y2Partitioner::Dialogs::Md::NameEntry"')
# textbox.set('mola')

# button = app.button(label: 'Help')
# button.press

# table = app.table(id: '"unselected"')
# items = table.items(selected_only: true)
# puts items.class
# puts items
# textbox = app.te(id: 'user_in')
# textbox.set('mola')

# numbox = app.numberbox(id: 'port')
# numbox.set('24')
# value = numbox.max_value
# print "#{value}\n"
# print "#{value.class}\n"
# print "#{numbox.value}\n"

# table = app.table(id: 'connected')
# puts table.empty?.class

# puts app.textbox(id: 'isns_address').valid_chars

# cond = app.textbox(id: 'isns_address').password?
# puts cond.class

# combo = app.combobox(id: 'service_widget_action')
# combo.select('Restart')
# puts combo.selected_item
# puts combo.items

# tab = app.tab(id: '_cwm_tab')
# tab.select('Co&nnected Targets')
# puts tab.items

# menubutton = app.menubutton(id: '"Y2Partitioner::Widgets::PartitionsButton"')
# menubutton.press_item("&Add Partition...")

# table = app.table(id: '"Y2Partitioner::Widgets::ConfigurableBlkDevicesTable"')
# table.select_row(value: 'swap', column: 'Mount Point')

# tree = app.tree(id: '"Y2Partitioner::Widgets::OverviewTree"')
# tree.select("System View")
# tree.select("susetest|Hard Disks")
# tree.select("susetest|Hard Disks|vda")
# tree.select("susetest|Hard Disks|vda|vda1")
# tree.select("susetest|Hard Disks|vda|vda2")
# tree.select("susetest|Hard Disks|vda|vda3")
# tree.select("susetest|RAID")
# tree.select("susetest|Hard Disks|vda")
# tree.select("susetest|Bcache")
# tree.select("susetest|Volume Management")
# tree.select("susetest|NFS")
# tree.select("susetest|Btrfs")
# tree.select("susetest|Btrfs|vda2")
# tree.select("susetest|Installation Summary")
# tree.select("susetest|Settings")
# puts tree.items
# puts tree.selected_item
