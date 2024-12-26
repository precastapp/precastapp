class Address{
  final String country;
  final String state;
  final String? district;
  final String city;
  final String street;
  final String? number;
  final String? complement;
  final String zipCode;

  const Address({
    required this.country,
    required this.state,
    this.district,
    required this.city,
    required this.street,
    this.number,
    this.complement,
    required this.zipCode,
  });
}