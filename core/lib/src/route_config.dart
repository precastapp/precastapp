import 'package:flutter/widgets.dart';

import 'module.dart';

class RouteConfig {
  final String route;
  final ValueGetter<Widget>? builder;
  final Module? module;
  final String Function(BuildContext context)? title;
  final IconData? icon;
  final IconData? selectedIcon;
  final List<RouteConfig> children;

  RouteConfig({
    required this.route,
    this.builder,
    this.module,
    this.title,
    this.icon,
    this.selectedIcon,
    this.children = const [],
  }) : assert(builder != null || module != null);
}