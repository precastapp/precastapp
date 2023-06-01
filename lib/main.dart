import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:precastapp/login_middlewar.dart';
import 'package:precastapp/pages/home_page.dart';
import 'package:precastapp/pages/welcome_page.dart';
import 'configure.dart' if (dart.library.html) 'configure_web.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var middlewares = [LoginMiddlewar()];

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = ThemeData(
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
      useMaterial3: true,
    );
    var darkTheme = ThemeData(
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange,
          brightness: Brightness.dark),
      useMaterial3: true
    );
    return GetMaterialApp(
      title: 'Precast template',
      theme: theme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/home',
      getPages: [
        GetPage(
            name: WelcomePage.routePath,
            page: ()=> WelcomePage()
        ),
        GetPage(
            name: HomePage.routePath,
            page: ()=> HomePage(),
            middlewares: middlewares
        ),
      ],
    );
  }
}
