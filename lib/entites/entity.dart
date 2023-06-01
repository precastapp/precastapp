
class Entity {
  String? id;
  DateTime createdAt = DateTime.now();
  DateTime? modifiedAt;

  Entity({this.id});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Entity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
