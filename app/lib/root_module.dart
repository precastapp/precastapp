import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:increment_sample/increment_sample.dart';
import 'package:people/people.dart';

import 'l10n/gen/l10n.dart';
import 'src/pages/main_page.dart';

class RootModule extends Module<RootModule> {
  final subRoutes = [
    RouteConfig(route: '/increment/', module: IncrementSampleModule()),
    RouteConfig(route: '/auth/', module: AuthModule()),
    RouteConfig(route: '/people/', module: PeopleModule()),
  ];

  @override
  List<RouteConfig> get pages => [
        RouteConfig(
          title: (c) => L10n.of(c).appTitle,
          route: '/',
          icon: Icons.home,
          builder: () => MainPage(subRoutes),
          children: subRoutes,
        ),
      ];
}
