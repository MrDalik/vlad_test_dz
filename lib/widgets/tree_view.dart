import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vlad_test/widgets/tree_node_widget.dart';

import '../models/tree_node.dart';
import '../providers/tree_provider.dart';

class TreeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final treeProvider = Provider.of<TreeProvider>(context);

    return ListView.builder(
      itemCount: treeProvider.rootNode.children.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return TreeNodeWidget(node: treeProvider.rootNode, treeProvider: treeProvider);
        } else {
          var childNode = treeProvider.rootNode.children[index-1];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TreeNodeWidget(node: childNode, treeProvider: treeProvider),
              if (childNode.isExpanded) ..._buildChildren(childNode, treeProvider),
            ],
          );
        }
      },
    );
  }

  List<Widget> _buildChildren(TreeNode node, TreeProvider treeProvider) {
    return node.children.map((child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TreeNodeWidget(node: child, treeProvider: treeProvider),
          if (child.isExpanded) ..._buildChildren(child, treeProvider),
        ],
      );
    }).toList();
  }
}
