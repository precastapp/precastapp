import 'package:account/account.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:precastapp/pages/home_page.dart';

import '../util/util.dart';

class WelcomePage extends StatelessWidget {
  static var routePath = '/welcome';
  AccountService userManagerService = Get.find();
  LocalStorage storage = Get.find();
  String? redirectTo;

  WelcomePage({this.redirectTo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kAppName),
      ),
      body: ListView(padding: EdgeInsets.all(kPadding), children: [
        FlutterLogo(size: 100),
        Center(
          child: Text(kAppName.tr),
        ),
        SizedBox(
          height: 16,
        ),
        ElevatedButton(
          child: Text('Sign in'.tr),
          onPressed: sigin,
        )
      ]),
    );
  }

  Future<void> sigin() async {
    var user = await userManagerService.signIn();
    if (user == null) return;

    Get.put(user, permanent: true);
    Get.offAllNamed(redirectTo ?? HomePage.routePath);
  }
}
