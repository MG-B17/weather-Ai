import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weatherai/core/error/failure.dart';
import 'package:weatherai/features/auth/Sing%20Up/domain/repo/SingUpRepo.dart';

import '../entity/SingUpEntity.dart';

class SingUpUseCase{
  final SingUpRepo singUpRepo;

  SingUpUseCase({required this.singUpRepo});

  Future<Either<Failure,UserCredential>>call({required SingUpEntity singUpEntity})async{
    return await singUpRepo.SingUp(singUpEntity: singUpEntity);
  }
}