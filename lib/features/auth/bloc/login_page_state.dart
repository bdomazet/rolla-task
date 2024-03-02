part of 'login_page_bloc.dart';

abstract class LoginPageState extends Equatable {
  const LoginPageState();
}

class LoginPageInitial extends LoginPageState {
  @override
  List<Object> get props => <Object>[];
}

class LogInSuccessfulState extends LoginPageState{
  @override
  List<Object> get props => <Object>[];
}

class LogInUnsuccessfulState extends LoginPageState{
  @override
  List<Object> get props => <Object>[];
}
