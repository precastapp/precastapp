import '../entites/user.dart';

abstract class AccountService {
  User? current;

  Future<User?> loadUser();

  Future<bool> signIn();

  Future<bool> signUp(User user, String password);

  Future<void> loggout();
}
