import 'package:core/core.dart';
import 'package:people/l10n/gen/l10n.dart';
import 'package:people/src/domain/entities/person.dart';
import 'package:people/src/domain/operations/list_all_people.dart';

import '../widgets/person_card.dart';

class PersonListPage extends StatelessWidget {
  const PersonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchBar(
          hintText: L10n.of(context).search,
        ),
      ),
      body: ListViewAsync<Person>.future(
        future: mediator.send(ListAllPeople()),
        itemBuilder: (context, person) => PersonCard(person: person),
        skeletonData: List.filled(
            7, Person(name: 'name asdf asdf asdf', emails: ['email'])),
      ),
    );
  }
}