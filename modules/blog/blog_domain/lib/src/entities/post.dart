import 'package:account/account.dart';
import 'package:core/core.dart';

class Post extends Entity {
  String title;
  String content;
  Account author;

  Post({required this.title, required this.content, required this.author});
}
