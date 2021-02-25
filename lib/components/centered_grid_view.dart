import 'package:flutter/material.dart';

class CenteredGridView extends StatelessWidget {
  const CenteredGridView({
    @required this.crossAxisCount,
    @required this.children,
    this.padding: EdgeInsets.zero,
  });

  final int crossAxisCount;
  final List<Widget> children;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    List<Widget> lastWidgets = [];

    int lastItemCount = children.length % crossAxisCount;

    for (var i = 0; i < lastItemCount; i++) {
      var lastItem = children.last;
      lastWidgets.add(lastItem);
      children.remove(lastItem);
    }

    Widget _wrapContainer(Widget child) {
      var i =
          (MediaQuery.of(context).size.width - (padding.right + padding.left)) /
              crossAxisCount;
      return Container(
        width: i,
        height: i,
        child: child,
      );
    }

    _buildLastWidget() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: lastWidgets.map((e) => _wrapContainer(e)).toList(),
      );
    }

    return Padding(
      padding: padding,
      child: Column(
        children: [
          if (children.length >= crossAxisCount)
            GridView.count(
              primary: false,
              shrinkWrap: true,
              crossAxisCount: crossAxisCount,
              children: children.map((e) => _wrapContainer(e)).toList(),
            ),
          _buildLastWidget(),
        ],
      ),
    );
  }
}
