import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weatherai/core/error/failure.dart';

import '../entity/entity.dart';

abstract class Repo {
  Future<Either<Failure,UserCredential>>login({required LoginEntity loginEntity});
}