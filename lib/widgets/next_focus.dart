import 'package:flutter/widgets.dart';

void nextFocusEditingComplete() {
  FocusManager.instance.primaryFocus?.nextFocus();
}
