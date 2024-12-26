import 'package:core/core.dart';
import 'package:increment_sample/l10n/gen/l10n.dart' as increment;
import 'package:people/l10n/gen/l10n.dart' as people;

import 'l10n/gen/l10n.dart';
import 'root_module.dart';

void main() {
  return runApp(ModuleApp(rootModule: RootModule(), child: const AppWidget()));
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ModuleApp.setInitialRoute('/increment');

    return MaterialApp.router(
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.purple, brightness: Brightness.dark)),
      routerConfig: ModuleApp.routerConfig,
      onGenerateTitle: (context) => L10n.of(context).appTitle,
      supportedLocales: L10n.supportedLocales,
      localizationsDelegates: const [
        ...L10n.localizationsDelegates,
        ...increment.L10n.localizationsDelegates,
        ...people.L10n.localizationsDelegates,
      ],
    ); //added by extension
  }
}
