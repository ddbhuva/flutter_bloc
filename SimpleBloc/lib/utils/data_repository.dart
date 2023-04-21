import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_bloc_demo/core/string_constant.dart';
import '../core/general_path.dart';
import 'app_exception.dart';
import 'global_widget.dart';

class DataRepository {
  final dio = Dio();

  Future<dynamic> getApi({
    required String apiURL,
  }) async {
    var url = GeneralPath.BASE_URI + apiURL;
    debugPrint('api : $url');
    var header = Options(
      headers: <String, dynamic>{
        'Authorization': "",
        'content-Type': "application/json",
      },
    );

    Response response;
    try {
      response = await dio.get(url, options: header);
      return response;
    } on SocketException {
      showToastMessage(noInternet);
      throw FetchDataException(noInternet, url.toString());
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> postApi({
    required String apiURL,Map<String, dynamic>? params, Object? dataPost,
  }) async {
    var url = GeneralPath.BASE_URI + apiURL;
    debugPrint('api : $url');
    var header = Options(
      headers: <String, dynamic>{
        'Authorization': "",
        'content-Type': "application/json",
      },
    );
    Response response;
    try {
      response = await dio.post(url, options: header, queryParameters: params, data: dataPost);
      return response;
    } on SocketException {
      showToastMessage(noInternet);
      throw FetchDataException(noInternet, url.toString());
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> putApi({

    required String apiURL,Object? dataPost,Map<String, dynamic>? params
  }) async {
    var url = GeneralPath.BASE_URI + apiURL;
    debugPrint('api : $url');
    var header = Options(
      headers: <String, dynamic>{
        'Authorization': "",
        'content-Type': "application/json",
      },
    );
    Response response;
    try {
      response = await dio.put(url, options: header, data: dataPost, queryParameters: params);
      return response;
    } on SocketException {
      showToastMessage(noInternet);
      throw FetchDataException(noInternet, url.toString());
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> deleteApi({
    required String apiURL,
  }) async {
    var url = GeneralPath.BASE_URI + apiURL;
    debugPrint('api : $url');
    var header = Options(
      headers: <String, dynamic>{
        'Authorization': "",
        'content-Type': "application/json",
      },
    );
    Response response;
    try {
      response = await dio.delete(url, options: header);
      return response;
    } on SocketException {
      showToastMessage(noInternet);
      throw FetchDataException(noInternet, url.toString());
    } catch (e) {
      return e.toString();
    }
  }
}
