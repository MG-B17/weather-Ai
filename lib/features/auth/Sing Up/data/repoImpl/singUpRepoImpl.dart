import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weatherai/core/error/exception.dart';
import 'package:weatherai/core/error/failure.dart';
import 'package:weatherai/core/network/network_checker.dart';
import 'package:weatherai/features/auth/Sing%20Up/data/remoteData/authRemoteData.dart';
import 'package:weatherai/features/auth/Sing%20Up/domain/entity/SingUpEntity.dart';
import 'package:weatherai/features/auth/Sing%20Up/domain/repo/SingUpRepo.dart';

import '../../../../../core/helpers/cacheHelper.dart';
import '../../../../../core/helpers/fireBase/fireBaseKey.dart';

class SingUpRepoImpl extends SingUpRepo{
  final SingUpRemote singUpRemote;
  final NetworkInfo networkInfo;

  SingUpRepoImpl({required this.singUpRemote,required this.networkInfo});
  @override
  Future<Either<Failure, UserCredential>> SingUp({required SingUpEntity singUpEntity})async {
    if(await networkInfo.isConnected()){
      try{
      final response= await singUpRemote.singUp(singUpEntity: singUpEntity);
      print(response.user!.uid);
      singUpRemote.createUser(singUpEntity: singUpEntity, uid: response.user!.uid);
      CacheHelper.setData(key: FireBaseKeys.uid, value: response.user!.uid);
      return right(response);
      }on WeekPassException{
        return left(WeekPassFailure());
      }on ExistedAccountException{
        return Left(ExistedAccountFailure());
      }on ServerException{
        return left(ServerFailure());
      }
    }else{
      return left(OfflineFailure());
    }
  }

}