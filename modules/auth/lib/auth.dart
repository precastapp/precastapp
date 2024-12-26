library auth;

import 'package:core/core.dart';

import 'src/presenter/login_page.dart' deferred as login_page;
import 'src/presenter/register_page.dart';

class AuthModule extends Module<AuthModule> {
  @override
  List<RouteConfig> get pages => [
        RouteConfig(
          title: (_) => 'Login',
          route: '/login',
          icon: Icons.login,
          builder: () {
            return loadLibrary(
              login_page.loadLibrary(),
              () => login_page.LoginPage(),
            );
          },
        ),
        RouteConfig(
          route: '/register',
          builder: () => const RegisterPage(),
        ),
      ];
}