import 'package:dio/dio.dart';

import '../../injection_container.dart';
import '../const/const.dart';
import '../enums/my_http_method.dart';
import '../models/user_model.dart';
import 'secure_storage_service.dart';

class NetworkService {
  NetworkService() {
    _dio = Dio();
  }

  late Dio _dio;
  UserModel? currentUser;
  final Map<String, dynamic> _headers = <String, dynamic>{
    'Content-Type': 'application/json'
  };

  Future<dynamic> _get(String url) async => _dio
          .get(url, options: Options(headers: _headers))
          .then((Response<dynamic> value) {
        return _checkResponseStatus(value);
      }).onError((dynamic error, StackTrace stackTrace) {
        throw Exception(error);
      });

  Future<dynamic> _getLargeFile(String url) async => _dio
          .get(url, options: Options(headers: <String, dynamic>{}))
          .then((Response<dynamic> value) {
        return _checkResponseStatus(value);
      }).onError((dynamic error, StackTrace stackTrace) {
        throw Exception(error);
      });

  Future<dynamic> _post(String url, {dynamic data}) async => _dio
          .post(url, options: Options(headers: _headers), data: data)
          .then((Response<dynamic> value) {
        return _checkResponseStatus(value);
      }).onError((dynamic error, StackTrace stackTrace) {
        throw Exception(error);
      });

  Future<dynamic> _put(String url, {dynamic data}) async => _dio
          .put(url, options: Options(headers: _headers), data: data)
          .then((Response<dynamic> value) {
        return _checkResponseStatus(value);
      }).onError((dynamic error, StackTrace stackTrace) {
        throw Exception(error);
      });

  dynamic _checkResponseStatus(Response<dynamic> value) {
    if (value.statusCode == 200) {
      return value.data;
    } else if (value.statusCode == 401) {
      logMeInAgain();
    } else {
      throw Exception('Status code not 200!');
    }
  }

  Future<void> logMeInAgain() async {
    _headers.clear();
    _headers.addAll(<String, dynamic>{'Content-Type': 'application/json'});
    final String? usernameTemp =
        await getIt<SecureStorage>().getString(username);
    final String? passwordTemp =
        await getIt<SecureStorage>().getString(password);

    _post('$baseURL/auth/login', data: <String, dynamic>{
      'username': usernameTemp ?? '',
      'password': passwordTemp ?? '',
      'expiresInMins': 10,
    }).then((dynamic value) {
      currentUser = UserModel.fromJson(value as Map<String, dynamic>);
      if (currentUser != null) {
        getIt<SecureStorage>().deleteString(tokenKey);
        getIt<SecureStorage>().addString(tokenKey, currentUser?.token ?? '');
      }
    });
    updateTokenInHeader();
  }

  void updateTokenInHeader() {
    _headers.addAll(<String, dynamic>{
      'Authorization': 'Bearer ${getIt<NetworkService>().currentUser?.token}'
    });
  }

  Future<dynamic> httpRequest({
    required String url,
    required MyHttpMethod method,
    dynamic data,
  }) async {
    switch (method) {
      case MyHttpMethod.get:
        return _get(url);
      case MyHttpMethod.post:
        return _post(url, data: data);
      case MyHttpMethod.put:
        return _put(url, data: data);
      case MyHttpMethod.getLargeFile:
        return _getLargeFile(url);
    }
  }
}
