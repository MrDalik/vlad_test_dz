import 'package:flutter/material.dart';

import '../models/tree_node.dart';
import '../providers/tree_provider.dart';

class TreeNodeWidget extends StatelessWidget {
  final TreeNode node;
  final TreeProvider treeProvider;

  TreeNodeWidget({required this.node, required this.treeProvider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          if (node.children.isNotEmpty)
            IconButton(
              icon: Icon(node.isExpanded ? Icons.remove : Icons.add),
              onPressed: () => treeProvider.toggleExpansion(node),
            ),
          Expanded(
            child: TextFormField(
              initialValue: node.text,
              onChanged: (value) {
                node.text = value;
                treeProvider.notifyListeners();
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          Checkbox(
            value: node.isChecked,
            onChanged: (_) => treeProvider.toggleCheck(node),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => treeProvider.addChild(node),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              if (node == treeProvider.rootNode) {
                return;
              }
              var parentNode = _findParent(treeProvider.rootNode, node);
              if (parentNode != null) {
                treeProvider.removeNode(parentNode, node);
              }
            },
          ),
        ],
      ),
    );
  }
  TreeNode? _findParent(TreeNode currentNode, TreeNode nodeToFind) {
    for (var child in currentNode.children) {
      if (child == nodeToFind) {
        return currentNode;
      } else {
        var parent = _findParent(child, nodeToFind);
        if (parent != null) {
          return parent;
        }
      }
    }
    return null;
  }
}
