
import 'package:simple_bloc_demo/crud/model/safe_convert.dart';

class GetDataModel {

  final List<DataItem>? data;

  GetDataModel({
     this.data,
  });

  factory GetDataModel.fromJson(Map<String, dynamic>? json) => GetDataModel(
    data: asT<List>(json, 'data').map((e) => DataItem.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'data': data?.map((e) => e.toJson()).toList(),
  };
}

class DataItem {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  DataItem({
    this.id = 0,
    this.email = "",
    this.firstName = "",
    this.lastName = "",
    this.avatar = "",
  });

  factory DataItem.fromJson(Map<String, dynamic>? json) => DataItem(
    id: asT<int>(json, 'id'),
    email: asT<String>(json, 'email'),
    firstName: asT<String>(json, 'first_name'),
    lastName: asT<String>(json, 'last_name'),
    avatar: asT<String>(json, 'avatar'),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'first_name': firstName,
    'last_name': lastName,
    'avatar': avatar,
  };
}

