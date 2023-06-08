import 'package:blog_ui/src/list_posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

class BlogHomePage extends StatefulWidget {
  static final routePath = '/blog';
  String title;

  BlogHomePage({this.title = 'Blog Home Page'});

  @override
  State<BlogHomePage> createState() => _BlogHomePageState();
}

class _BlogHomePageState extends State<BlogHomePage> {
  var selectedIndex = 0;
  var destinations = [
    NavigationDestination(
      label: 'Home',
      icon: Icon(Icons.home),
    ),
    NavigationDestination(
      label: 'My Posts',
      icon: Icon(Icons.my_library_books_outlined),
    ),
    NavigationDestination(
      label: 'Exit',
      icon: Icon(Icons.exit_to_app),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AppBar(title: Text(widget.title)),
      internalAnimations: true,
      selectedIndex: selectedIndex,
      useDrawer: false,
      onSelectedIndexChange: onNavegationSelected,
      body: buildBody,
      destinations: destinations,
    );
  }

  onNavegationSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    if (destinations.length - 1 == index)
      Navigator.of(context, rootNavigator: true).pop();
  }

  Widget buildBody(BuildContext context) {
    switch (selectedIndex) {
      case 0:
        return ListPosts();
    }
    return Text('data: $selectedIndex');
  }
}
