class TreeNode {
  String text;
  bool isChecked;
  bool isExpanded;
  List<TreeNode> children;
  TreeNode? parent;

  TreeNode({
    required this.text,
    this.isChecked = false,
    this.isExpanded = false,
    List<TreeNode>? children,
    this.parent,
  }) : children = children ?? [];

  void addChild(TreeNode child) {
    child.parent = this;
    children.add(child);
  }

  void removeChild(TreeNode child) {
    children.remove(child);
  }

  void toggleCheck() {
    isChecked = !isChecked;
    updateParentCheckState();
  }

  void updateParentCheckState() {
    if (parent != null) {
      bool allChecked = parent!.children.every((child) => child.isChecked);
      bool anyChecked = parent!.children.any((child) => child.isChecked);

      parent!.isChecked = allChecked;
      parent!.isChecked = anyChecked ? true : parent!.isChecked;

      parent!.updateParentCheckState();
    }
  }

  void propagateCheck(bool value) {
    isChecked = value;
    for (var child in children) {
      child.propagateCheck(value);
    }
  }

  void toggleExpansion() {
    isExpanded = !isExpanded;
  }
}
