import 'package:core/core.dart';
import 'package:home/home.dart';
import 'package:home/l10n/gen/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int menuIndex = 0;

  @override
  Widget build(BuildContext context) {
    final title = Text(L10n.of(context).welcome);
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
        for (final route in HomeModule.subPages)
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
    ModuleApp.navigateTo(HomeModule.subPages[index].route);
  }
}