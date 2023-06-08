import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ListPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      gridDelegate: SliverStairedGridDelegate(
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        startCrossAxisDirectionReversed: true,
        pattern: [
          StairedGridTile(0.5, 1),
          StairedGridTile(0.5, 3 / 4),
          StairedGridTile(1.0, 10 / 4),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) => Card(
          child: GridTile(child: Text('$index')),
          margin: EdgeInsets.all(8),
        ),
      ),
    );
  }
}
