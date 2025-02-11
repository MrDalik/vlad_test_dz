class TreeNode {
  String text;
  bool isChecked;
  bool isExpanded;
  List<TreeNode> children;

  TreeNode({
    required this.text,
    this.isChecked = false,
    this.isExpanded = false,
    List<TreeNode>? children,
  }) : children = children ?? [];

  void addChild(TreeNode child) {
    children.add(child);
  }

  void removeChild(TreeNode child) {
    children.remove(child);
  }

  void toggleCheck() {
    isChecked = !isChecked;
  }

  void propagateCheck(bool value) {
    isChecked = value;
    for (var child in children) {
      child.propagateCheck(value);
    }
  }
}
