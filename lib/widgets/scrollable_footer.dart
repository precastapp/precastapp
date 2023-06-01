import 'package:flutter/material.dart';

class ScrollableFooter extends StatelessWidget {
  Widget footer;
  List<Widget> children;

  ScrollableFooter({
    required this.children,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: constraints.copyWith(
            minHeight: constraints.maxHeight,
            maxHeight: double.infinity,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: <Widget>[
                for (var w in children) w,
                Expanded(
                  child:
                      Align(alignment: Alignment.bottomCenter, child: footer),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
