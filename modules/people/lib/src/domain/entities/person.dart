import 'address.dart';
import 'identification_document.dart';

class Person {
  final String name;
  final List<String> alternateNames;
  final DateTime? birthDate;
  final List<String> phones;
  final List<String> emails;
  final String photo;
  final Address? address;
  final List<IdentificationDocument>? identificationDocuments;

  Person({
    required this.name,
    this.alternateNames = const [],
    this.birthDate,
    this.phones = const [],
    this.emails = const [],
    this.photo = '',
    this.address,
    this.identificationDocuments,
  });
}