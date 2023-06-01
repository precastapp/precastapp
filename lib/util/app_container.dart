class AppContainer {
  static late T Function<T>(T object, {String? tag, bool permanent}) add;
  static late T Function<T>({String? tag}) get;
  static late void Function<T>(T Function(), {String? tag, bool fenix}) addLazy;
  static late Future<bool> Function<S>({bool force, String? tag}) delete;
  static late bool Function<T>({String? tag}) contains;
}
