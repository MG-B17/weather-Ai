import 'package:equatable/equatable.dart';

abstract class Failure {}

class OfflineFailure extends Failure {}

class ServerFailure extends Failure {}

class WeekPassFailure extends Failure {}

class ExistedAccountFailure extends Failure {}

class NoUserFailure extends Failure {}

class WrongPasswordFailure extends Failure {}