import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'global_widget.dart';


class AppException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  AppException([this.message, this.prefix, this.url]);
}

class BadRequestException extends AppException {
  BadRequestException([String? message, String? url]) : super(message, 'Bad Request', url);
}

class FetchDataException extends AppException {
  FetchDataException([String? message, String? url]) : super(message, 'Unable to process', url);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException([String? message, String? url]) : super(message, 'Api not responded in time', url);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message, String? url]) : super(message, 'UnAuthorized request', url);
}


// custom status code for exception or response not success
Future<bool> checkStatusCode(response) async {
  debugPrint('responsestatus code: ${response}');
  if (response.statusCode == 400) {
    Map<String, dynamic> mResponse = jsonDecode(response.body);
    showToastMessage('Please contact with admin: \n ${mResponse["message"]}');
    return Future<bool>.value(false);
  } else if (response.statusCode == 500) {
    Map<String, dynamic> mResponse = jsonDecode(response.body);
    showToastMessage('Please contact with admin: \n ${mResponse["message"]}');
    return Future<bool>.value(false);
  }/*else if (response.statusCode == 504) {
    // time out exception and show custom dialog
    dynamic refreshApi = await showTimeoutDialog();
    debugPrint('refreshApi: $refreshApi');
    if(refreshApi == true){
      return Future<bool>.value(true);
    }else {
      return Future<bool>.value(false);
    }
  } else if (response.statusCode == 403 || response.statusCode == 401) {
    Map<String, dynamic> mResponse = jsonDecode(response.body);
    // token is expired , set new token and call api again
    if (mResponse["message"] == invalidToken) {
      dynamic refreshToken = await refreshFirebaseUser();
      if (refreshToken
          .toString()
          .isNotEmpty) {
        return Future<bool>.value(true);
      } else {
        return Future<bool>.value(false);
      }
    } else {
      showToastMessage('Please contact with admin: \n ${mResponse["message"]}');
      return Future<bool>.value(false);
    }
  } */else {
    Map<String, dynamic> mResponse = jsonDecode(response.body);
    showToastMessage('Please contact with admin: \n ${mResponse["message"]}');
    return Future<bool>.value(false);
  }
}