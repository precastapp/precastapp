import 'package:core/core.dart';

import '../../l10n/gen/l10n.dart';
import 'menu_destination.dart';

class MainPage extends StatefulWidget {
  final List<RouteConfig> subRoutes;

  const MainPage(this.subRoutes, {super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int menuIndex = 0;
  late final List<MenuDestination> destinations;

  @override
  void initState() {
    super.initState();
    destinations = widget.subRoutes.map((e) {
      final firstPage = e.module!.pages.first;
      return MenuDestination(
        route: e.route,
        icon: firstPage.icon!,
        selectedIcon: firstPage.selectedIcon,
        title: firstPage.title!,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final title = Text(L10n.of(context).appTitle);
    return AdaptiveScaffold(
      useDrawer: false,
      appBarBreakpoint: Breakpoints.small,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: title,
      ),
      leadingExtendedNavRail: title,
      leadingUnextendedNavRail: title,
      onSelectedIndexChange: selectIndexMenu,
      selectedIndex: menuIndex,
      body: (c) => const RouterOutlet(),
      destinations: [
        for (final route in destinations)
          NavigationDestination(
            icon: Icon(route.icon),
            selectedIcon: Icon(route.selectedIcon ?? route.icon),
            label: route.title != null ? route.title!(context) : '',
          ),
      ], // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void selectIndexMenu(int index) {
    setState(() {
      menuIndex = index;
    });
    ModuleApp.navigate(destinations[index].route);
  }
}
