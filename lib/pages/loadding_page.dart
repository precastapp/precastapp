import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'error_page.dart';

class LoaddingPage extends StatelessWidget {
  static Widget future<T>({
    required Future<T> future,
    required Widget Function(T? data) builder,
    T? initialData,
  }) {
    return FutureBuilder<T>(
      initialData: initialData,
      future: future,
      builder: (c, s) => _builder(c, s, builder, initialData),
    );
  }

  static _builder<T>(
    BuildContext c, AsyncSnapshot<T> snap, Widget Function(T? data) builder, T? initialData
  ) {
    return initialData != null
      ? builder(initialData) 
      : snap.connectionState == ConnectionState.waiting
        ? LoaddingPage()
        : snap.hasError
            ? ErrorPage(
                message: snap.error.toString(), stackTrace: snap.stackTrace ?? StackTrace.current)
            : builder(snap.data);
  }

  static Widget stream<T>({
    required Stream<T> stream,
    required Widget Function(T? data) builder,
    T? initialData
  }) {
    return StreamBuilder<T>(
      initialData: initialData,
      stream: stream,
      builder: (c, s) => _builder(c, s, builder, initialData),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Loadding".tr)),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
