import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:weatherai/core/network/network_checker.dart';
import 'package:weatherai/features/auth/Sing%20Up/data/remoteData/authRemoteData.dart';
import 'package:weatherai/features/auth/Sing%20Up/domain/repo/SingUpRepo.dart';
import 'package:weatherai/features/auth/Sing%20Up/domain/useCase/SingUp_UseCase.dart';
import 'package:weatherai/features/auth/Sing%20Up/presentation/controller/cubit.dart';
import 'package:weatherai/features/auth/login/data/remoteData/remoteData.dart';
import 'package:weatherai/features/auth/login/data/repo_Impl/repo_Impl.dart';
import 'package:weatherai/features/auth/login/domain/usecase/loginUseCase.dart';
import 'package:weatherai/features/auth/login/presentation/controller/cubit.dart';
import 'package:weatherai/features/home/data/remoteData/remoteWeatherData.dart';
import 'package:weatherai/features/home/data/rep_impl/weatherRepo_Imple.dart';
import 'package:weatherai/features/home/domain/repo/repo.dart';
import 'package:weatherai/features/home/domain/usecase/getCurrentWeatherUseCase.dart';
import 'package:weatherai/features/home/domain/usecase/getForecastWeatherUseCase.dart';
import 'package:weatherai/features/home/presentation/controller/cubit.dart';

import '../../features/auth/Sing Up/data/repoImpl/singUpRepoImpl.dart';
import '../../features/auth/login/domain/repo/repo.dart';

final sl = GetIt.instance;

Future<void> init()async{
  //cubit
  sl.registerFactory(()=>LoginCubit(loginUseCase: sl()));
  sl.registerFactory(()=>SingUpCubit(singUpUseCase: sl()));
  sl.registerFactory(()=>WeatherCubit(getCurrentWeatherUSeCase: sl(),getForecastWeatherUSeCase: sl())..getCurrentWeather());

  //useCase
  sl.registerLazySingleton<LoginUseCase>(()=>LoginUseCase(repo: sl()));
  sl.registerLazySingleton<SingUpUseCase>(()=>SingUpUseCase(singUpRepo: sl()));
  sl.registerLazySingleton<GetCurrentWeatherUSeCase>(()=>GetCurrentWeatherUSeCase(weatherRepo: sl()));
  sl.registerLazySingleton<GetForecastWeatherUSeCase>(()=>GetForecastWeatherUSeCase(weatherRepo: sl()));

  //repo
  sl.registerLazySingleton<Repo>(()=>RepoImpl(networkInfo: sl(), remoteData:sl()));
  sl.registerLazySingleton<SingUpRepo>(()=>SingUpRepoImpl(singUpRemote: sl(), networkInfo: sl()));
  sl.registerLazySingleton<WeatherRepo>(()=>CurrentWeatherImpel(networkInfo: sl(), baseRemoteWeatherData: sl()));

  //remoteData
  sl.registerLazySingleton<RemoteData>(()=>RemoteDataLogin());
  sl.registerLazySingleton<SingUpRemote>(()=>SingUpRemoteImpl());
  sl.registerLazySingleton<BaseRemoteWeatherData>(()=>RemoteWeatherData());

  //other
  sl.registerLazySingleton<NetworkInfo>(()=>NetworkInfoImpl(internetConnection: InternetConnection()));
}