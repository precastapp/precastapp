import 'package:account/account.dart';
import 'package:core/core.dart';

class Comment extends Entity {
  String content;
  Account author;
  Comment? parent;

  Comment({required this.content, required this.author, this.parent});
}
