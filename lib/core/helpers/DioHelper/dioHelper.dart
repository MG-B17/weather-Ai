import 'package:dio/dio.dart';
import 'package:weatherai/core/helpers/DioHelper/ApiStrings.dart';

class DioHelper {

 static Dio? dio;

  static initialDio(){
   dio = Dio(BaseOptions(
      baseUrl:ApiStrings.baseUrl,
      receiveDataWhenStatusError: true,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
    ));
  }

  static Future<Map<String,dynamic>> get({required String endPoint,required Map<String,dynamic> query})async{
   final response =await dio?.get(endPoint,queryParameters:query);
    return response?.data;
  }


}