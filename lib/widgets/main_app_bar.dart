import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:precastapp/services/account_service.dart';

import '../util/util.dart';

class MainAppBar extends AppBar {
  MainAppBar()
      : super(
            leading: IconButton(
              icon: Icon(Icons.person_outlined),
              onPressed: () => Get.toNamed('/profile'),
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.remove_red_eye_outlined), onPressed: () {}),
              IconButton(icon: Icon(Icons.help_outline), onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.person_add_outlined), onPressed: () {}),
            ],
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(kPadding),
                child: Padding(
                    padding: EdgeInsets.all(kPadding),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Olá ${Get.find<AccountService>().current!.name}',
                          style: Get.textTheme.titleLarge
                              ?.copyWith(color: Get.theme.bottomAppBarTheme.color),
                          textAlign: TextAlign.center,
                        )))));
}
