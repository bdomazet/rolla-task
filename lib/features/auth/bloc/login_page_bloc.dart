import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/const/const.dart';
import '../../../core/enums/my_http_method.dart';
import '../../../core/models/user_login_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/services/network_service.dart';
import '../../../core/services/secure_storage_service.dart';
import '../../../injection_container.dart';

part 'login_page_event.dart';
part 'login_page_state.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  LoginPageBloc() : super(LoginPageInitial()) {
    on<LogMeInEvent>(onLogMeInEvent);
  }

  FutureOr<void> onLogMeInEvent(
      LogMeInEvent event, Emitter<LoginPageState> emit) async {
    await getIt<NetworkService>()
        .httpRequest(
            url: '$baseURL/auth/login',
            method: MyHttpMethod.post,
            data: UserLoginModel(
                    username: event.username,
                    password: event.password,
                    expiresInMins: event.expiresInMins)
                // expiresInMins: event.expiresInMins)
                .toJson())
        .then((dynamic value) => <UserModel>{
              getIt<NetworkService>().currentUser =
                  UserModel.fromJson(value as Map<String, dynamic>)
            });

    if (getIt<NetworkService>().currentUser != null) {
      await getIt<SecureStorage>().addString(username, event.username);
      await getIt<SecureStorage>().addString(password, event.password);
      await getIt<SecureStorage>().addString(
          tokenKey, getIt<NetworkService>().currentUser?.token ?? '');
      getIt<NetworkService>().updateTokenInHeader();
      emit(LogInSuccessfulState());
    } else {
      emit(LogInUnsuccessfulState());
    }
  }
}
