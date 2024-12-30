import '../../model/user/user_model.dart';

/// Abstract class defining methods for authentication API repositories.
abstract class AuthApiRepository {
  /// Sends a login request to the authentication API with the provided [data].
  ///
  /// Returns a [UserModel] representing the user data if the login is successful.
  Future<dynamic> loginApi(dynamic data);
  Future<dynamic> signupApi(dynamic data);
  Future<dynamic> saveuserData(dynamic data);
}
