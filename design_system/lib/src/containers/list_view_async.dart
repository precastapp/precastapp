import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListViewAsync<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Stream<List<T>>? stream;
  final Future<List<T>>? future;
  final WidgetBuilder? separator;
  final List<T> skeletonData;

  const ListViewAsync.stream({
    super.key,
    required this.itemBuilder,
    required Stream<List<T>> this.stream,
    this.separator,
    this.skeletonData = const [],
  }) : future = null;

  const ListViewAsync.future({
    super.key,
    required this.itemBuilder,
    required Future<List<T>> this.future,
    this.separator,
    this.skeletonData = const [],
  }) : stream = null;

  @override
  Widget build(BuildContext context) {
    Widget asyncBuilder(BuildContext context, AsyncSnapshot<List<T>> snapshot) {
      if (skeletonData.isEmpty && !snapshot.hasData) {
        return const Center(child: CircularProgressIndicator());
      }

      final list = snapshot.data ?? skeletonData;

      return Skeletonizer(
        enabled: !snapshot.hasData,
        child: ListView.separated(
          itemBuilder: (context, index) => itemBuilder(context, list[index]),
          separatorBuilder: (context, index) =>
              separator == null ? const SizedBox() : separator!(context),
          itemCount: list.length,
        ),
      );
    }

    return future != null
        ? FutureBuilder(future: future!, builder: asyncBuilder)
        : StreamBuilder(stream: stream!, builder: asyncBuilder);
  }
}