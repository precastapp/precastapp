import 'package:flutter/material.dart';

import 'error_message_widget.dart';

class LoaddingWidget extends StatelessWidget{

static Widget future<T>({
    required Future<T> future,
    required Widget Function(T? data) builder,
    T? initialData
  }) {
    return FutureBuilder<T>(
      initialData: initialData,
      future: future,
      builder: (c, s) => _builder(c, s, builder),
    );
  }

  static _builder<T>(
    BuildContext c, AsyncSnapshot<T> snap, Widget Function(T? data) builder
  ) {
    return snap.connectionState == ConnectionState.waiting
      ? LoaddingWidget()
      : snap.hasError
          ? ErrorMessageWidget(
              snap.error.toString(), snap.stackTrace ?? StackTrace.current)
          : builder(snap.data);
  }

  static Widget stream<T>({
    required Stream<T> stream,
    required Widget Function(T? data) builder,
  }) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (c, s) => _builder(c, s, builder),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}