import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:home/home.dart';

class RootModule extends Module<RootModule> {
  final home = HomeModule();
  final auth = AuthModule();

  @override
  Map<String, Module> get submodules => {
        '/home': home,
        '/auth': auth,
      };
}