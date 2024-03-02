import 'package:dartz/dartz.dart';

import '../error/failure.dart';
import '../models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel?>> getUser();
}
