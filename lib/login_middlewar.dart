import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:precastapp/pages/welcome_page.dart';

import 'entites/user.dart';

class LoginMiddlewar extends GetMiddleware {
  var ignoreRoutes = [];

  @override
  RouteSettings? redirect(String? route) {
    if (!Get.isRegistered<User>() && !ignoreRoutes.contains(route))
      return RouteSettings(name: WelcomePage.routePath, arguments: route);

    return null;
  }
}
