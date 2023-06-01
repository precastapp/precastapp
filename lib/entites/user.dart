import 'entity.dart';

class User extends Entity {
  String name;
  String username;
  String email;
  String? phone;
  String? image;

  User(
      {String? id,
      required this.name,
      required this.username,
      required this.email,
      this.phone,
      this.image})
      : super(id: id);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'username': username,
      'phone': phone,
      'image': image,
    };
  }
}
