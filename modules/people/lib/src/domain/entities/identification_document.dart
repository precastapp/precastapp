class IdentificationDocument {
  final String type;
  final String number;
  final DateTime? expirationDate;

  IdentificationDocument({
    required this.type, required this.number, this.expirationDate,
  });
}