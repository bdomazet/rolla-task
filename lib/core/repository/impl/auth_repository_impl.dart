import 'package:dartz/dartz.dart';

import '../../error/failure.dart';
import '../../models/user_model.dart';
import '../auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either<Failure, UserModel?>> getUser() async {
    try {
      // final dynamic result =
      //     await getIt<NetworkService>().httpRequest(url: url, method: method);
      // return Right<Failure, UserModel?>(result);
    } on Exception catch (e) {
      return Left<Failure, UserModel?>(ServerFailure(message: e.toString()));
    }
    throw UnimplementedError();
  }
}
