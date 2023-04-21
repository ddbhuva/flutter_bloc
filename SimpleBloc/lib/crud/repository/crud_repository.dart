import 'package:flutter/cupertino.dart';
import '../../utils/data_repository.dart';

class CrudRepository {

  final _provider = DataRepository();

  Future<dynamic> getData({required String url,}) async {
      debugPrint("Url: $url");
    return _provider.getApi(apiURL: url,);
  }

  Future<dynamic> postData({required String url, Object? dataPost, Map<String, dynamic>? paramsReq}) {
      debugPrint("Url: $url datapost: $dataPost");
    return _provider.postApi(apiURL: url, params: paramsReq);
  }

  Future<dynamic> putData({required String url, Object? dataPost, Map<String, dynamic>? paramsReq }) {
      debugPrint("Url: $url datapost: $dataPost");
    return _provider.putApi(apiURL: url, params: paramsReq,);
  }

  Future<dynamic> deleteData({required String url,}) {
      debugPrint("Url: $url");
    return _provider.deleteApi(apiURL: url, );
  }
}
