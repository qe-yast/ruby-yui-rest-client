# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a Treeview in UI. It can be YTree.
    class Tree < Widgets::Widget
      # include Behaviors::ItemSelectable

      # Returns the list of items available to select from tree. Each item
      # is represented by its path from root node to leaf in the tree,
      # in other words, a list of nodes separated by special simbol '|'
      # @return [Array] array of Strings.
      # @example Get items from tree with id "test_id"
      #  {
      #    "class": "YTree",
      #    "debug_label": "node_0",
      #    "hstretch": true,
      #    "hweight": 30,
      #    "icon_base_path": "",
      #    "id": "test_id",
      #    "items": [
      #      {
      #        "children": [
      #          {
      #            "icon_name": "icon",
      #            "label": "node1_1"
      #          },
      #          {
      #            "children": [
      #              {
      #                "label": "node_1_2_1"
      #              },
      #              {
      #                "label": "node_1_2_2",
      #                "selected": true
      #              }
      #            ],
      #            "icon_name": "icon",
      #            "label": "node1_2"
      #          }
      #        ],
      #        "icon_name": "icon",
      #        "label": "node1",
      #        "selected": true
      #      },
      #      {
      #        "icon_name": "icon",
      #        "label": "node2"
      #      }
      #    ],
      #    "items_count": 2,
      #    "label": "node_0",
      #    "notify": true,
      #    "vstretch": true
      #  }
      # @example
      #   app.tree(id: 'test_id').items
      #   # node1
      #   # node1|node1_1
      #   # node1|node1_2
      #   # node1|node1_2|node1_2_1
      #   # node1|node1_2|node1_2_2
      #   # node2
      def items
        traverse_tree(property(:items))
      end

      # Returns the item currently selected/highlighted in the tree. Item
      # is represented by its path from root node to leaf in the tree,
      # in other words, a list of nodes separated by special simbol '|'
      # @return [String] item selected/highlighted in the tree
      # @example Get selected item from tree with id "test_id"
      #  {
      #    "class": "YTree",
      #    "debug_label": "node_0",
      #    "hstretch": true,
      #    "hweight": 30,
      #    "icon_base_path": "",
      #    "id": "test_id",
      #    "items": [
      #      {
      #        "children": [
      #          {
      #            "icon_name": "icon",
      #            "label": "node1_1"
      #          },
      #          {
      #            "children": [
      #              {
      #                "label": "node_1_2_1"
      #              },
      #              {
      #                "label": "node_1_2_2",
      #                "selected": true
      #              }
      #            ],
      #            "icon_name": "icon",
      #            "label": "node1_2"
      #          }
      #        ],
      #        "icon_name": "icon",
      #        "label": "node1",
      #        "selected": true
      #      },
      #      {
      #        "icon_name": "icon",
      #        "label": "node2"
      #      }
      #    ],
      #    "items_count": 2,
      #    "label": "node_0",
      #    "notify": true,
      #    "vstretch": true
      #  }
      # @example
      #   app.tree(id: 'test_id').selected_item
      #   # node1|node1_2|node1_2_2
      def selected_item
        items = traverse_tree(property(:items), flag_selected: true)
        items.select { |item| item.start_with?('*') }.first[1..-1]
      end

      private

      def traverse_tree(items, path = '', flag_selected: false)
        array = []
        items.each do |item|
          current_path = path + item[:label]
          apply_flag = flag_selected && item.key?(:selected)
          array << (apply_flag ? '*' + current_path : current_path)
          if item.key?(:children)
            array << traverse_tree(item[:children], current_path + '|', flag_selected: flag_selected)
          end
        end
        array.flatten
      end
    end
  end
end
