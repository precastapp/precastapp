import '../entites/account.dart';

abstract class AccountService {
  Account? current;

  Future<Account?> loadUser();

  Future<Account?> signIn();

  Future<bool> signUp(Account user, String password);

  Future<void> loggout();
}
