import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weatherai/core/error/exception.dart';
import 'package:weatherai/core/error/failure.dart';
import 'package:weatherai/core/helpers/cacheHelper.dart';
import 'package:weatherai/core/helpers/fireBase/fireBaseKey.dart';
import 'package:weatherai/core/network/network_checker.dart';
import 'package:weatherai/features/auth/login/data/remoteData/remoteData.dart';
import 'package:weatherai/features/auth/login/domain/repo/repo.dart';

import '../../domain/entity/entity.dart';

class RepoImpl implements Repo{
  final NetworkInfo networkInfo;
  final RemoteData remoteData ;

  RepoImpl({required this.networkInfo,required this.remoteData});
  @override
  Future<Either<Failure, UserCredential>> login({required LoginEntity loginEntity})async {
    if(await networkInfo.isConnected()){
      try{
       final response= await remoteData.Login(loginEntity: loginEntity);
       return right(response);
      }on ServerException{
        return left(ServerFailure());
      }on WrongPasswordException{
        return left(WrongPasswordFailure());
      }
    }else{
      return left(OfflineFailure());
    }
  }

}