import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Column(children: [
        Text('Ops!! \nNão encontrei essa página!', style: Get.textTheme.headline2),
        ElevatedButton(
          child: Text('Página inicial'),
          onPressed: ()=> Get.toNamed('/'),
        )
      ],)),
    );
  }
}