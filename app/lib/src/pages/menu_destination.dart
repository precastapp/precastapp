import 'package:core/core.dart';

class MenuDestination {
  final String Function(BuildContext context)? title;
  final String route;
  final IconData icon;
  final IconData? selectedIcon;

  const MenuDestination({
    required this.title,
    required this.route,
    required this.icon,
    required this.selectedIcon,
  });
}
