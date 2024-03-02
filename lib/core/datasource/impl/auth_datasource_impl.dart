import '../../../injection_container.dart';
import '../../const/const.dart';
import '../../enums/my_http_method.dart';
import '../../models/user_model.dart';
import '../../services/network_service.dart';
import '../auth_datasource.dart';

class AuthDatasourceImpl extends AuthDatasource {
  @override
  Future<UserModel?> logUserIn() async {
    final UserModel? userModel;
    userModel = await getIt<NetworkService>()
        .httpRequest(url: '$baseURL/auth/login', method: MyHttpMethod.get)
        .then((dynamic value) {
      return UserModel.fromJson(value as Map<String, dynamic>);
    });
    return userModel;
  }
}
