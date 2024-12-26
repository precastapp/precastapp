import 'package:core/core.dart';
import 'package:people/l10n/gen/l10n.dart';

import 'domain/operations/list_all_people.dart';
import 'presenter/pages/person_list_page.dart';

class PeopleModule extends Module<PeopleModule> {
  @override
  List<RouteConfig> get pages {
    return [
      RouteConfig(
        route: '/people',
        builder: () => const PersonListPage(),
        title: (context) => L10n.of(context).contacts,
        icon: Icons.contacts,
      ),
    ];
  }

  @override
  void binds(Injector i) {
    mediator.register(ListAllPeopleHandler());
  }
}