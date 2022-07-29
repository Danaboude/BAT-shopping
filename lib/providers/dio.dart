import 'package:dio/dio.dart';


Dio dio(){
  Dio dio=new Dio();
  dio.options.baseUrl='http://192.168.43.235:80/api';
  dio.options.sendTimeout=4000;
  dio.options.connectTimeout=4000;
  dio.options.receiveTimeout=5000;
  dio.options.headers['accept']='Application/Json';
 dio.options.headers["Connection"]= "Keep-Alive";
  return dio;
}