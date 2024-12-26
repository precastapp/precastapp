import 'dart:convert';

import 'package:core/core.dart';

import '../../domain/entities/person.dart';

class PersonCard extends StatelessWidget {
  final Person person;

  const PersonCard({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(person.name),
        subtitle: person.emails.isEmpty ? null : Text(person.emails.first),
        leading: CircleAvatar(
          backgroundImage: person.photo.isEmpty
              ? null
              : MemoryImage(base64Decode(person.photo)),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}