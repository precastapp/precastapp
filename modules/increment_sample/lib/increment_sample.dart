library increment_sample;

import 'package:core/core.dart';

import 'increment_sample_page.dart';

class IncrementSampleModule extends Module<IncrementSampleModule> {
  @override
  List<RouteConfig> get pages => [
        RouteConfig(
          title: (_) => 'Increment',
          route: '/',
          icon: Icons.add,
          builder: () => const IncrementSamplePage(),
        ),
      ];
}