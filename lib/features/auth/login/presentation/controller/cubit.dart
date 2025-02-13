import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherai/core/error/handelError.dart';
import 'package:weatherai/features/auth/login/domain/entity/entity.dart';
import 'package:weatherai/features/auth/login/domain/usecase/loginUseCase.dart';
import 'package:weatherai/features/auth/login/presentation/controller/states.dart';

import '../../../../../core/error/failure.dart';

class LoginCubit extends Cubit<LoginStates>{
  final LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase}): super(InitialLoginState());

  static LoginCubit of(BuildContext context) =>
      BlocProvider.of<LoginCubit>(context);

  Future<void> login({required String password, required String email})
  async {
    emit(LoadingLogin());
    final entity = LoginEntity(email: email, password: password);
   final Either<Failure, UserCredential> result = await loginUseCase(loginEntity: entity);
   // print(result);
   result.fold(
           (failure){emit(LoginFail(message: MapFailureToMessage(failure)));},
           (_){emit(LoginSuccess());}
   );
  }
}