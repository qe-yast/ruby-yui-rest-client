# frozen_string_literal: true

module LibyuiClient
  module Widgets
    # Class representing a tree in UI. It can be YTree.
    class Tree < Widgets::Base
      # Returns the list of items available to select from tree. Each item
      # is represented by its path from root node to leaf in the tree,
      # in other words, a list of nodes separated by special simbol '|'
      # @return [Array<String>] array of strings
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
      #                "label": "node1_2_1"
      #              },
      #              {
      #                "label": "node1_2_2",
      #                "selected": true
      #              }
      #            ],
      #            "icon_name": "icon",
      #            "label": "node1_2"
      #          }
      #        ],
      #        "icon_name": "icon",
      #        "label": "node1",
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
        get_nodes(property(:items))
      end

      # Sends action to select an item from the tree in UI.
      # @param item [String] value to select from items.
      # @example Select tree node 'test_node' from tree with id 'test_id'
      #   app.tree(id: 'test_id').select('test_node')
      def select(item)
        action(action: Actions::SELECT, value: item)
        self
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
        get_selected_node(property(:items))
      end

      private

      def get_nodes(items, root = '')
        items.map do |x|
          current = root.empty? ? x[:label] : root + '|' + x[:label]
          x.key?(:children) ? [current, get_nodes(x[:children], current)] : current
        end.flatten
      end

      def get_selected_node(items, root = '')
        selected = ''
        items.each do |x|
          current = root.empty? ? x[:label] : root + '|' + x[:label]
          return current if x[:selected]

          selected = get_selected_node(x[:children], current) if x.key?(:children)
          break unless selected.empty?
        end
        selected
      end
    end
  end
end
