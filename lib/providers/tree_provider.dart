import 'package:flutter/cupertino.dart';

import '../models/tree_node.dart';

class TreeProvider with ChangeNotifier {
  TreeNode rootNode;

  TreeProvider() : rootNode = TreeNode(text: 'Root');

  void toggleCheck(TreeNode node) {
    node.toggleCheck();
    notifyListeners();
  }

  void addChild(TreeNode parentNode) {
    TreeNode newNode = TreeNode(text: 'New Child');
    parentNode.addChild(newNode);
    notifyListeners();
  }

  void removeNode(TreeNode parentNode, TreeNode node) {
    parentNode.removeChild(node);
    notifyListeners();
  }

  void toggleExpansion(TreeNode node) {
    node.toggleExpansion();
    print("Node ${node.text} isExpanded: ${node.isExpanded}");
    notifyListeners();
  }
}
