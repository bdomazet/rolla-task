import '../models/user_model.dart';

abstract class AuthDatasource {
  Future<UserModel?> logUserIn();
}
