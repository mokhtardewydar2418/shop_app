import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper
{
  static Dio dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      )
    );
  }

  static Future<Response> getData({
    @required String url,
    Map<String,dynamic> queries,
    String lang = 'ar',
    String token,
}) async
  {
    dio.options.headers =
    {
      'Content-Type' : 'application/json' ,
      'lang' : lang,
      'Authorization' : token ??''
    };

    return await dio.get(
      url,
      queryParameters: queries,
    );
  }

  static Future<Response> postData({
    @required String url,
    @required Map<String,dynamic> data,
    Map<String,dynamic> queries,
    String lang = 'ar',
    String token,
}) async
  {
    dio.options.headers =
    {
      'Content-Type' : 'application/json' ,
      'lang' : lang,
      'Authorization' : token ??''
    };

    return await dio.post(
      url,
      data: data,
      queryParameters: queries
    );
  }

  static Future<Response> putData({
    @required String url,
    @required Map<String,dynamic> data,
    Map<String,dynamic> queries,
    String lang = 'ar',
    String token,

}) async
{
  dio.options.headers=
  {
    'Content-Type' : 'application/json' ,
    'lang' : lang,
    'Authorization' : token ??''

  };
  return await dio.put(
    url,
    data: data,
    queryParameters: queries,
  );
}

}