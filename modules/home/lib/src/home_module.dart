import 'package:core/core.dart';
import 'package:increment_sample/increment_sample.dart';
import 'package:people/people.dart';

import 'home_page.dart';

class HomeModule extends Module<HomeModule> {
  final increment = ();
  final people = PeopleModule();

  @override
  List<RouteConfig> get pages => [
        RouteConfig(
          title: (_) => 'Home',
          route: '/',
          icon: Icons.home,
          builder: () => const HomePage(),
          children: subPages,
        ),
      ];

  static List<RouteConfig> subPages = [
    ...<Module>[IncrementSampleModule(), PeopleModule()].map((m) {
      final page = m.pages.first;
      return RouteConfig(
        route: '/home${page.route}',
        module: m,
        icon: page.icon,
        selectedIcon: page.selectedIcon,
        title: page.title,
      );
    }),
    ...ModuleApp.rootModule.submodules.entries
        .where((t) => t.value.runtimeType != HomeModule)
        .map((m) {
      final page = m.value.pages.first;
      return RouteConfig(
        route: m.key,
        builder: page.builder,
        icon: page.icon,
        selectedIcon: page.selectedIcon,
        title: page.title,
      );
    })
  ];
}