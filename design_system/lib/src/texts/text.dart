import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Text extends StatelessWidget{
  final String markdownSource;
  final TextStyle? style;

  const Text(this.markdownSource, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(data: markdownSource, styleSheet: MarkdownStyleSheet(p: style));
  }

}