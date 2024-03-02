part of 'login_page_bloc.dart';

abstract class LoginPageEvent extends Equatable {
  const LoginPageEvent();
}

class LogMeInEvent extends LoginPageEvent {
  const LogMeInEvent(
      {required this.username,
      required this.password,
      required this.expiresInMins});
  final String username;
  final String password;
  final String expiresInMins;

  @override
  List<Object?> get props => <Object?>[];
}
