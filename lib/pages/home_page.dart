import 'package:account/account.dart';
import 'package:blog_ui/blog_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:precastapp/util/global_values.dart';

class HomePage extends StatelessWidget {
  static var routePath = '/home';
  Account user = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kAppName),
        actions: [
          TextButton.icon(
            icon: Icon(Icons.exit_to_app),
            onPressed: exit,
            label: Text('Exit'.tr),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(kPadding),
        children: [
          if (user.image != null)
            CircleAvatar(
              radius: 150,
              backgroundColor: Colors.blueGrey.shade100,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Image.network(user.image!, scale: .1),
              ),
            ),
          Text(user.name),
          Text(user.email),
          if (user.phone != null) Text(user.phone!),
          ElevatedButton(
            onPressed: () => Get.toNamed(BlogHomePage.routePath),
            child: Text('Blog Home Page'.tr),
          )
        ],
      ),
    );
  }

  void exit() {
    AccountService service = Get.find();
    service.loggout();
  }
}
