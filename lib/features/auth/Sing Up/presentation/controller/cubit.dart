import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherai/core/error/handelError.dart';
import 'package:weatherai/features/auth/Sing%20Up/domain/entity/SingUpEntity.dart';
import 'package:weatherai/features/auth/Sing%20Up/domain/useCase/SingUp_UseCase.dart';
import 'package:weatherai/features/auth/Sing%20Up/presentation/controller/states.dart';

class SingUpCubit extends Cubit<SingUpStates>{
  final SingUpUseCase singUpUseCase;

  SingUpCubit({required this.singUpUseCase}):super(InitialSingUpState());

  static SingUpCubit of(BuildContext context) =>
      BlocProvider.of<SingUpCubit>(context);

   singUp({required String userName, required String email, required String password,required String birthDate, required String height, required String weight, required BuildContext context,})async{
    emit(LoadingSingUp());
    final entity = SingUpEntity(userName: userName, email: email, password: password,birthDate: birthDate,weight: weight,height: height);
   final result= await singUpUseCase(singUpEntity: entity);
   result.fold((failure)=>emit(SingUpFail(message:MapFailureToMessage(failure) )), (_)=>emit(SingUpSuccess()));
  }
}