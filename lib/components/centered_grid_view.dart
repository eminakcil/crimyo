import 'package:flutter/material.dart';

class CenteredGridView extends StatelessWidget {
  const CenteredGridView({
    this.crossAxisCount,
    this.children,
  });

  final int crossAxisCount;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    List<Widget> lastWidgets = [];

    int lastItemCount = children.length % crossAxisCount;

    for (var i = 0; i < lastItemCount; i++) {
      var lastItem = children.last;
      lastWidgets.add(lastItem);
      children.remove(lastItem);
    }

    _buildLastWidget() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: lastWidgets,
      );
    }

    return Column(
      children: [
        GridView.count(
          primary: false,
          shrinkWrap: true,
          crossAxisCount: crossAxisCount,
          children: children,
        ),
        _buildLastWidget(),
      ],
    );
  }
}
