import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Increment Sample';

  @override
  String get message => 'You have pushed the button this many times:';
}
