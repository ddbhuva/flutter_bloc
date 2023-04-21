import 'package:simple_bloc_demo/crud/model/safe_convert.dart';


class AddDataModel {
  final String name;
  final String job;
  final String id;
  final String createdAt;

  AddDataModel({
    this.name = "",
    this.job = "",
    this.id = "",
    this.createdAt = "",
  });

  factory AddDataModel.fromJson(Map<String, dynamic>? json) => AddDataModel(
    name: asT<String>(json, 'name'),
    job: asT<String>(json, 'job'),
    id: asT<String>(json, 'id'),
    createdAt: asT<String>(json, 'createdAt'),
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'job': job,
    'id': id,
    'createdAt': createdAt,
  };

  AddDataModel copyWith({
    String? name,
    String? job,
    String? id,
    String? createdAt,
  }) {
    return AddDataModel(
      name: name ?? this.name,
      job: job ?? this.job,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'job': job,
      'id': id,
      'createdAt': createdAt,
    };
  }

  factory AddDataModel.fromMap(Map<String, dynamic> map) {
    return AddDataModel(
      name: map['name'] as String,
      job: map['job'] as String,
      id: map['id'] as String,
      createdAt: map['createdAt'] as String,
    );
  }
}

