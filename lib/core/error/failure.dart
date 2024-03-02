import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
  const Failure({this.errorMessage});
  final String? errorMessage;

  @override
  List<Object?> get props => <Object?>[errorMessage];
}

class ServerFailure extends Failure {
  const ServerFailure({this.message}) : super(errorMessage: message);
  final String? message;
}

class UserNotRegisteredFailure extends Failure {
  const UserNotRegisteredFailure();
}

class UnauthenticatedUserFailure extends Failure {
  const UnauthenticatedUserFailure();
}

class UserNotFoundFailure extends Failure {}

class GenericFailure extends Failure {}
