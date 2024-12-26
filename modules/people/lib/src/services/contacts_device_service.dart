import 'dart:convert';

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:people/src/domain/entities/person.dart';

class ContactsDeviceService {
  static Future<List<Person>> getPeopleOnDevice() async {
    List<Contact> contacts = await FlutterContacts.getContacts();
    return contacts
        .map((contact) => Person(
              name: contact.displayName,
              phones: contact.phones.map((f) => f.number).toList(),
              emails: contact.emails.map((f) => f.address).toList(),
              photo: contact.thumbnailFetched
                  ? base64Encode(contact.thumbnail!)
                  : '',
            ))
        .toList();
  }
}